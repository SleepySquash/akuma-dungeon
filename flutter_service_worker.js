'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "8279ffa686674b62c83b6c355bfbf61f",
"index.html": "081e8b34b87965bf53f250dce8f2c481",
"/": "081e8b34b87965bf53f250dce8f2c481",
"main.dart.js": "88f9210964843ba5f5953e279cfb3b62",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1cc0dfdd0d5febf3197d9c909452b777",
"assets/AssetManifest.json": "e32e77ae50c5ed18c7daf3b017c4e495",
"assets/NOTICES": "306fc1b24f7babc4b028b9d04441a12d",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/background/room/renovation.jpg": "d5394b1daaca462b545450a30188ff5c",
"assets/assets/background/location/modern_city_sunrise.jpg": "776462bec62b18f6b1627b3e731b33d7",
"assets/assets/background/location/park.jpg": "e268041a94c1f262cbf3bc133591f382",
"assets/assets/background/location/town.jpg": "9e56e3e9938bc8ce186273acc7f63210",
"assets/assets/background/location/forest_house.jpg": "06a057e6ae5b31c5a598947001e2c0b3",
"assets/assets/background/location/guild.jpg": "e8b0ca108e19ccf6339853e8756eaf98",
"assets/assets/background/dungeon/fields.jpg": "2948cdaea86242332e74ba5e280df170",
"assets/assets/background/dungeon/akuma.jpg": "c8c71646cd24f7623855d489af8d453b",
"assets/assets/background/dungeon/forest.jpg": "0305296aa2317a9e61976aa26aca64e1",
"assets/assets/background/dungeon/swarm.jpg": "cd8a07f9ba02f3a0f241cae292619d02",
"assets/assets/background/dungeon/destructed_city.jpg": "a7fbab8a2b8662667573a13e44a4b5af",
"assets/assets/music/MOSAIC.WAV_tohoketemodamedesu%25EF%25BC%2581.mp3": "f49e170b72ca718d849783331f51ba87",
"assets/assets/music/MOSAICWAV_she_already_gone.mp3": "537fcca75968e2d35657b46c1c51b7f0",
"assets/assets/music/MOSAIC.WAV_mezamenourutsu.mp3": "d1787d59914ef5782aaac42151fcdbb8",
"assets/assets/l10n/en-US.ftl": "73eeaf58f9cc23fe7a650e69aa2974cf",
"assets/assets/l10n/ru-RU.ftl": "12005367b7ea1c15365dc8087eeaf0dc",
"assets/assets/character/Luke.png": "9ec1de33221c037df0c7b53c825b09ba",
"assets/assets/character/Jenny.png": "87003ace57bad72734afc7b5a83346dd",
"assets/assets/character/Zahir.png": "bbbd8d1f3933fe25cdcdc909e9900cd7",
"assets/assets/character/Nadine.png": "34c50ba4854a5d122df239ae3fc55e03",
"assets/assets/character/HyunWoo.png": "576fd1ad115c518fd6258041e7d7f2d2",
"assets/assets/character/Nathapon.png": "a3ee6a277c71101f52e59c57078ab195",
"assets/assets/character/Nicky0.png": "2a5c34ecd8d1b8ce586e12d4d39416bc",
"assets/assets/character/Sua.png": "ae33f9937bdd0a6f0203616c7a3666cf",
"assets/assets/character/Rio.png": "55b986b75f30de0530af658a6e9a3378",
"assets/assets/character/Arda.png": "1165e72ee0b3a3acbe823df09d324ede",
"assets/assets/character/Adriana.png": "504f88b4a401793b23cb68d94554b81c",
"assets/assets/character/Rozzi.png": "e0fbd677b88e8723303ba4f5de976575",
"assets/assets/character/Dr._Nadja.png": "c18625aabe29dadf259ddd9aa69d9f88",
"assets/assets/character/Adela.png": "937cf4adc4f7f521c71a5bc928ea73f1",
"assets/assets/character/Yuki.png": "c8e66600b45751ec58ddba957b8ab2cb",
"assets/assets/character/JP.png": "82e2bc70d76a3691a2932f10b30058bc",
"assets/assets/character/Clever_Floyd.png": "cc085b74151d9f2d05f0da053c5f16d0",
"assets/assets/character/Camilo.png": "e30d410c7b572a809a173c540c5a320e",
"assets/assets/character/Alex.png": "07fdf2244311db58672798ac305a3621",
"assets/assets/character/Shoichi.png": "f135006fba58e4fb64d8ac4cd9673fb7",
"assets/assets/character/Lenox.png": "ce83eba8f8a8e0a925d1978d3a56a535",
"assets/assets/character/Mai.png": "f92ff239973cd3c6c1fd598d1562c7ba",
"assets/assets/character/Chiara.png": "ce3f0d03b2f0e17b4cb3429c6c68099f",
"assets/assets/character/Magnus.png": "6928c565fdcfa70530979c26f51d8245",
"assets/assets/character/Dr._Thomas.png": "edb31b91dc2d6a1176588685c07398bf",
"assets/assets/character/Silvia.png": "ba2fdb4d0f15679725b1366b0e587241",
"assets/assets/character/Leon.png": "5ec80086554439aa05a2de12e5ff8e65",
"assets/assets/character/Li_Dailin.png": "b80f247599e2b4f2463d36f214f7dce5",
"assets/assets/character/Eleven.png": "9618dd00a4e849e88de23b4448823aee",
"assets/assets/character/Emma.png": "eb6ae88fe74c539eceedc4bf747e3cc6",
"assets/assets/character/William.png": "0f0322c82ffb068ee48d66eca00289e6",
"assets/assets/character/Bernice.png": "251cc5553fc7fc98ce24dc2235af5578",
"assets/assets/character/Daniel.png": "4c1ec47088d2a5d6f038150ea5d45dd0",
"assets/assets/character/Hart.png": "5918e74bd33858fdb02afb801d5d2043",
"assets/assets/character/Fiora.png": "356773a3b2e212fc4ac9e5581a7eb7a8",
"assets/assets/character/Jan.png": "11e7d2ec422bc6bb3df04e895f297596",
"assets/assets/voice/intro/8.m4a": "77e3cc6fe58a10354a57c53d64ac6292",
"assets/assets/voice/intro/9.m4a": "96594b3b7dab586bbd77c6f9aa61837b",
"assets/assets/voice/intro/4.mp3": "0091f0caf5cb87fd9d725e3afb0826fb",
"assets/assets/voice/intro/1.mp3": "b4240e548a9da291dafb192aaac89c4d",
"assets/assets/voice/intro/3.mp3": "10bbea338d878a7c2f41613e536db139",
"assets/assets/voice/intro/11.m4a": "ad23d2f8b878d0c1a23ff04e98df66f4",
"assets/assets/voice/intro/10.m4a": "69c14dcbc5bc8f9c36349851c8218bc1",
"assets/assets/voice/intro/12.m4a": "36c21ea2bea5775e22eec06b154ca950",
"assets/assets/voice/intro/13.m4a": "86648b0f24ff4f9a1838db2344cbd556",
"assets/assets/voice/intro/17.m4a": "0be72ab6213d959bec34b714b37ed25a",
"assets/assets/voice/intro/16.m4a": "db73519e118208dcc6d2382817a5d8e3",
"assets/assets/voice/intro/28.m4a": "d3b1612b5c7f07ab2d4b3b2905669c91",
"assets/assets/voice/intro/14.m4a": "86cba233bf72355745484bd86db57d55",
"assets/assets/voice/intro/15.m4a": "6edfbad032da35be6756fdfc52eef026",
"assets/assets/voice/intro/29.m4a": "9ca6535c5dc087b9c125f8e89030e0c0",
"assets/assets/voice/intro/30.m4a": "df6318741046dd64692a4ae3696e6276",
"assets/assets/voice/intro/24.m4a": "e2284210c67b32bbd6b32b465136c5b8",
"assets/assets/voice/intro/18.m4a": "936fa420656e079e9483d4086ca33581",
"assets/assets/voice/intro/19.m4a": "870ce9cc435b6829c995434206336cb6",
"assets/assets/voice/intro/25.m4a": "09437fbf0e945ba91ca02c7c385f9e0b",
"assets/assets/voice/intro/31.m4a": "6085b0184c981b980a4b50a0c774bb2f",
"assets/assets/voice/intro/27.m4a": "5c9b2c034ca5e6c6b111e7ee453206ae",
"assets/assets/voice/intro/32.m4a": "1a9c7b8139f347dfc05f3b50f848b023",
"assets/assets/voice/intro/26.m4a": "0befbd8005c26689e30ae0e8d44785f3",
"assets/assets/voice/intro/22.m4a": "bffdd4ab3d24ad60423868ffb651dbf8",
"assets/assets/voice/intro/23.m4a": "d11b355b0abc847b5a47d92b3e9dcf87",
"assets/assets/voice/intro/21.m4a": "e3612a3d8ac971cb007886200b594738",
"assets/assets/voice/intro/20.m4a": "9da7f2618f81424f293f14c0cffe5cb1",
"assets/assets/voice/intro/2.m4a": "e7272e2c54eab702a0ccb8d711e6c0da",
"assets/assets/voice/intro/7.m4a": "1ea3a477a3837fdec8d126a89329f6c7",
"assets/assets/voice/intro/6.m4a": "59ba065dfce5361501e6fba7dc77865c",
"assets/assets/voice/intro/5.m4a": "63eb559d6b71d126de51476e9089e061",
"assets/assets/font/Roboto-Medium.ttf": "68ea4734cf86bd544650aee05137d7bb",
"assets/assets/font/Roboto-Light.ttf": "881e150ab929e26d1f812c4342c15a7c",
"assets/assets/font/BalsamiqSans-Bold.ttf": "c75d3e69ca7abfce44252cf9e3efe854",
"assets/assets/font/Neucha-Regular.ttf": "ba10e84e04783d0cf957000b0386d2a9",
"assets/assets/font/Roboto-Regular.ttf": "8a36205bd9b83e03af0591a004bc97f4",
"assets/assets/font/Roboto-MediumItalic.ttf": "c16d19c2c0fd1278390a82fc245f4923",
"assets/assets/font/Roboto-ThinItalic.ttf": "7bcadd0675fe47d69c2d8aaef683416f",
"assets/assets/font/BalsamiqSans-Italic.ttf": "a30c44ec69e52f41706f19beb7a51df6",
"assets/assets/font/Roboto-BoldItalic.ttf": "fd6e9700781c4aaae877999d09db9e09",
"assets/assets/font/Roboto-LightItalic.ttf": "5788d5ce921d7a9b4fa0eaa9bf7fec8d",
"assets/assets/font/BalsamiqSans-BoldItalic.ttf": "28231ae49f474820048e577ea368dbe6",
"assets/assets/font/Roboto-Italic.ttf": "cebd892d1acfcc455f5e52d4104f2719",
"assets/assets/font/Roboto-BlackItalic.ttf": "c3332e3b8feff748ecb0c6cb75d65eae",
"assets/assets/font/Roboto-Bold.ttf": "b8e42971dec8d49207a8c8e2b919a6ac",
"assets/assets/font/Roboto-Thin.ttf": "66209ae01f484e46679622dd607fcbc5",
"assets/assets/font/Roboto-Black.ttf": "d6a6f8878adb0d8e69f9fa2e0b622924",
"assets/assets/font/BalsamiqSans-Regular.ttf": "18524b8dcfb7a7fa8650e2d9b3f17330",
"assets/assets/monster/Green%2520Slime.png": "7f7a9651133ef4025f42aa2d3189d658",
"assets/assets/monster/Red%2520Slime.png": "44108197f395c357b8d4e672a75bd25d",
"assets/assets/monster/Blue%2520Slime.png": "a51972fb1c730253cb74be7f7770ed8a",
"assets/assets/monster/Cat%2520Slime.png": "3f95ed05d7d69c270505cab6b15cc560",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
