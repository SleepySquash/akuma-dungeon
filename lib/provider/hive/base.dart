// Copyright © 2022 NIKITA ISAENKO, <https://github.com/SleepySquash>
//
// This program is free software: you can redistribute it and/or modify it under
// the terms of the GNU Affero General Public License v3.0 as published by the
// Free Software Foundation, either version 3 of the License, or (at your
// option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License v3.0 for
// more details.
//
// You should have received a copy of the GNU Affero General Public License v3.0
// along with this program. If not, see
// <https://www.gnu.org/licenses/agpl-3.0.html>.

import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mutex/mutex.dart';
import 'package:universal_io/io.dart';

import '/domain/model_type_id.dart';

/// Base class for data providers backed by [Hive].
abstract class HiveBaseProvider<T> extends DisposableInterface {
  /// [Box] that contains all of the data.
  late Box<T> box;

  /// Indicator whether the underlying [Box] was opened and can be used.
  bool isReady = false;

  /// [Mutex] that guards [_box] access.
  final Mutex _mutex = Mutex();

  /// Indicates whether there are no entries in this [Box].
  bool get isEmpty => box.isEmpty;

  /// Returns a broadcast stream of Hive [Box] change events.
  Stream<BoxEvent> get boxEvents => box.watch();

  /// Name of the underlying [Box].
  @protected
  String get boxName;

  /// Exception-safe wrapper for [Box.values] returning all the values in the
  /// [box].
  Iterable<T> get valuesSafe {
    if (isReady && box.isOpen) {
      return box.values;
    }
    return [];
  }

  @protected
  void registerAdapters() {}

  /// Opens a [Box] and changes [isReady] to true.
  ///
  /// Should be called before using underlying [Box].
  Future<void> init() async {
    registerAdapters();
    await _mutex.protect(() async {
      try {
        box = await Hive.openBox<T>(
          boxName,
          compactionStrategy: (i, j) => true,
        );
      } catch (e) {
        await Future.delayed(Duration.zero);
        await Hive.deleteBoxFromDisk(boxName);
        box = await Hive.openBox<T>(boxName);
      }
      isReady = true;
    });
  }

  /// Removes all entries from the [Box].
  @mustCallSuper
  Future<void> clear() => _mutex.protect(() async {
        if (isReady) {
          await box.clear();
        }
      });

  /// Closes the [Box].
  @mustCallSuper
  Future<void> close() => _mutex.protect(() async {
        if (isReady && box.isOpen) {
          isReady = false;

          try {
            await box.close();
          } on FileSystemException {
            // No-op.
          }
        }
      });

  @override
  void onClose() async {
    await close();
    super.onClose();
  }

  /// Exception-safe wrapper for [BoxBase.put] saving the [key] - [value] pair.
  Future<void> putSafe(dynamic key, T value) {
    if (isReady && box.isOpen) {
      return box.put(key, value);
    }
    return Future.value();
  }

  /// Exception-safe wrapper for [Box.get] returning the value associated with
  /// the given [key], if any.
  T? getSafe(dynamic key, {T? defaultValue}) {
    if (isReady && box.isOpen) {
      return box.get(key, defaultValue: defaultValue);
    }
    return null;
  }

  /// Exception-safe wrapper for [BoxBase.delete] deleting the given [key] from
  /// the [box].
  Future<void> deleteSafe(dynamic key, {T? defaultValue}) {
    if (isReady && box.isOpen) {
      return box.delete(key);
    }
    return Future.value();
  }
}

abstract class HiveLazyProvider<T> extends DisposableInterface {
  late LazyBox<T> box;
  bool isReady = false;

  final Mutex _mutex = Mutex();

  bool get isEmpty => box.isEmpty;

  Stream<BoxEvent> get boxEvents => box.watch();

  @protected
  String get boxName;

  /// Exception-safe wrapper for [Box.values] returning all the values in the
  /// [box].
  Iterable<dynamic> get keysSafe {
    if (isReady && box.isOpen) {
      return box.keys;
    }
    return [];
  }

  @protected
  void registerAdapters();

  Future<void> init() async {
    registerAdapters();
    await _mutex.protect(() async {
      try {
        box = await Hive.openLazyBox<T>(
          boxName,
          compactionStrategy: (i, j) => true,
        );
      } catch (e) {
        await Future.delayed(Duration.zero);
        await Hive.deleteBoxFromDisk(boxName);
        box = await Hive.openLazyBox<T>(boxName);
      }
      isReady = true;
    });
  }

  /// Removes all entries from the [Box].
  @mustCallSuper
  Future<void> clear() => _mutex.protect(() async {
        if (isReady) {
          await box.clear();
        }
      });

  /// Closes the [Box].
  @mustCallSuper
  Future<void> close() => _mutex.protect(() async {
        if (isReady && box.isOpen) {
          isReady = false;

          try {
            await box.close();
          } on FileSystemException {
            // No-op.
          }
        }
      });

  @override
  void onClose() async {
    await close();
    super.onClose();
  }

  /// Exception-safe wrapper for [BoxBase.put] saving the [key] - [value] pair.
  Future<void> putSafe(dynamic key, T value) {
    if (isReady && box.isOpen) {
      return box.put(key, value);
    }
    return Future.value();
  }

  /// Exception-safe wrapper for [Box.get] returning the value associated with
  /// the given [key], if any.
  Future<T?> getSafe(dynamic key, {T? defaultValue}) {
    if (isReady && box.isOpen) {
      return box.get(key, defaultValue: defaultValue);
    }
    return Future.value(null);
  }

  /// Exception-safe wrapper for [BoxBase.delete] deleting the given [key] from
  /// the [box].
  Future<void> deleteSafe(dynamic key, {T? defaultValue}) {
    if (isReady && box.isOpen) {
      return box.delete(key);
    }
    return Future.value();
  }
}

extension HiveRegisterAdapter on HiveInterface {
  /// Tries to register the given [adapter].
  void maybeRegisterAdapter<A>(TypeAdapter<A> adapter) {
    if (!Hive.isAdapterRegistered(adapter.typeId)) {
      Hive.registerAdapter<A>(adapter);
    }
  }
}

class DecimalAdapter extends TypeAdapter<Decimal> {
  @override
  int get typeId => ModelTypeId.decimal;

  @override
  Decimal read(BinaryReader reader) {
    final String value = reader.read() as String;
    return Decimal.parse(value);
  }

  @override
  void write(BinaryWriter writer, Decimal obj) {
    writer.write(obj.toString());
  }
}
