'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "1066359641ec1cef11abbf9df1e282cc",
"index.html": "ab2ed24f9d04ed69c2b38920d33770ea",
"/": "ab2ed24f9d04ed69c2b38920d33770ea",
"main.dart.js": "b385da224510493d79ffd20c202fa6b4",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "1cc0dfdd0d5febf3197d9c909452b777",
"assets/AssetManifest.json": "97ac61a77db3abfbf4aae20c70d9eb3c",
"assets/NOTICES": "59dfcb324fa712f9857f32ffbbca91ab",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/shaders/ink_sparkle.frag": "0d06ee32a159a396d0d8f8c835b432b4",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/background/misc/sky.jpg": "31546ec04f38fc20ae20012ac9657770",
"assets/assets/background/room/renovation.jpg": "d5394b1daaca462b545450a30188ff5c",
"assets/assets/background/location/modern_city_sunrise.jpg": "776462bec62b18f6b1627b3e731b33d7",
"assets/assets/background/location/park.jpg": "e268041a94c1f262cbf3bc133591f382",
"assets/assets/background/location/town.jpg": "9e56e3e9938bc8ce186273acc7f63210",
"assets/assets/background/location/forest_house.jpg": "06a057e6ae5b31c5a598947001e2c0b3",
"assets/assets/background/location/guild.jpg": "e8b0ca108e19ccf6339853e8756eaf98",
"assets/assets/background/dungeon/forest2.jpg": "bd4808855348cbbaf4416b305a835ba1",
"assets/assets/background/dungeon/fields.jpg": "2948cdaea86242332e74ba5e280df170",
"assets/assets/background/dungeon/swamp.jpg": "cd8a07f9ba02f3a0f241cae292619d02",
"assets/assets/background/dungeon/akuma.jpg": "c8c71646cd24f7623855d489af8d453b",
"assets/assets/background/dungeon/forest.jpg": "0305296aa2317a9e61976aa26aca64e1",
"assets/assets/background/dungeon/library.jpg": "38778fc71762cb565d5f09d95f3c242d",
"assets/assets/background/dungeon/city_street.jpg": "ea7dd75d9cf246f2cb6e0b143e30a645",
"assets/assets/background/dungeon/urban_street.jpg": "2ac8e04b15207ac2a1039d1360b01179",
"assets/assets/background/dungeon/stone_ruins_jungle.jpg": "0d0dae7b47d82899a4ddd8b1e98d0084",
"assets/assets/background/dungeon/living_room_pink.jpg": "a494e4542d31abc44aadea39f5c9ad71",
"assets/assets/background/dungeon/warehouse.jpg": "677e0d02db1e8d8903846c155ca7fef8",
"assets/assets/background/dungeon/magic_forest_altar.jpg": "ac47aeecdb83e15393b870a5f6d5a0ed",
"assets/assets/background/dungeon/destructed_city.jpg": "a7fbab8a2b8662667573a13e44a4b5af",
"assets/assets/background/dungeon/throne.jpg": "9080f62fa138f3a9d441eb2ba9518c71",
"assets/assets/music/MOSAIC.WAV_tohoketemodamedesu%25EF%25BC%2581.mp3": "f49e170b72ca718d849783331f51ba87",
"assets/assets/music/mixkit-games-worldbeat-466.mp3": "535d17d66d03e4a4c3996422ea47890e",
"assets/assets/music/MOSAICWAV_she_already_gone.mp3": "537fcca75968e2d35657b46c1c51b7f0",
"assets/assets/music/MOSAIC.WAV_mezamenourutsu.mp3": "d1787d59914ef5782aaac42151fcdbb8",
"assets/assets/music/mixkit-forest-treasure-138.mp3": "9403783416b156c803a1bd2137ac6aa5",
"assets/assets/music/mixkit-driving-ambition-32.mp3": "b17640d37a7293618724a030392ba400",
"assets/assets/l10n/en-US.ftl": "73eeaf58f9cc23fe7a650e69aa2974cf",
"assets/assets/l10n/ru-RU.ftl": "12005367b7ea1c15365dc8087eeaf0dc",
"assets/assets/character/Luke.png": "9ec1de33221c037df0c7b53c825b09ba",
"assets/assets/character/Jenny.png": "87003ace57bad72734afc7b5a83346dd",
"assets/assets/character/Zahir.png": "bbbd8d1f3933fe25cdcdc909e9900cd7",
"assets/assets/character/Nadine.png": "34c50ba4854a5d122df239ae3fc55e03",
"assets/assets/character/HyunWoo.png": "576fd1ad115c518fd6258041e7d7f2d2",
"assets/assets/character/Nathapon.png": "a3ee6a277c71101f52e59c57078ab195",
"assets/assets/character/Nicky0.png": "2a5c34ecd8d1b8ce586e12d4d39416bc",
"assets/assets/character/Sua.png": "554e45942ac9196b10ad87b4c6a19261",
"assets/assets/character/Rio.png": "036fe379c6fc29f59d8bfcc12273f581",
"assets/assets/character/Arda.png": "1165e72ee0b3a3acbe823df09d324ede",
"assets/assets/character/Adriana.png": "504f88b4a401793b23cb68d94554b81c",
"assets/assets/character/Rozzi.png": "615b9cb7ec5bde4420035c9f6e9e5655",
"assets/assets/character/Dr._Nadja.png": "c8f675ec591cc2da78aa03a2c7d70a29",
"assets/assets/character/Adela.png": "937cf4adc4f7f521c71a5bc928ea73f1",
"assets/assets/character/Yuki.png": "c8e66600b45751ec58ddba957b8ab2cb",
"assets/assets/character/JP.png": "82e2bc70d76a3691a2932f10b30058bc",
"assets/assets/character/Clever_Floyd.png": "cc085b74151d9f2d05f0da053c5f16d0",
"assets/assets/character/Camilo.png": "e30d410c7b572a809a173c540c5a320e",
"assets/assets/character/Alex.png": "07fdf2244311db58672798ac305a3621",
"assets/assets/character/Shoichi.png": "f135006fba58e4fb64d8ac4cd9673fb7",
"assets/assets/character/Lenox.png": "ce83eba8f8a8e0a925d1978d3a56a535",
"assets/assets/character/Mai.png": "2933e516308b3c9a4a40ef0b46b9d093",
"assets/assets/character/Chiara.png": "ce3f0d03b2f0e17b4cb3429c6c68099f",
"assets/assets/character/Magnus.png": "c8aa8876aea081256740ff2ce98ca6cc",
"assets/assets/character/Dr._Thomas.png": "fb1773193cdf78de19c447db453db4a1",
"assets/assets/character/Silvia.png": "ba2fdb4d0f15679725b1366b0e587241",
"assets/assets/character/Leon.png": "5ec80086554439aa05a2de12e5ff8e65",
"assets/assets/character/Li_Dailin.png": "b80f247599e2b4f2463d36f214f7dce5",
"assets/assets/character/Eleven.png": "8c01a8ed9adf34b669a7f1b3e4843aab",
"assets/assets/character/Emma.png": "56ee3e81f037362050062af22b4c2d40",
"assets/assets/character/William.png": "0f0322c82ffb068ee48d66eca00289e6",
"assets/assets/character/Bernice.png": "251cc5553fc7fc98ce24dc2235af5578",
"assets/assets/character/Daniel.png": "23f14711dfb95be33875d1a042e9da16",
"assets/assets/character/Hart.png": "5918e74bd33858fdb02afb801d5d2043",
"assets/assets/character/Fiora.png": "356773a3b2e212fc4ac9e5581a7eb7a8",
"assets/assets/character/Jan.png": "99952779405febfcaa2fec817deb996d",
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
"assets/assets/voice/sfx/newlevel_1.m4a": "ab881e076d4b6ca474b0ead61160a31d",
"assets/assets/voice/sfx/newlevel_3.m4a": "e61d80a0e19c7da06f7382f4864f74c1",
"assets/assets/voice/sfx/newlevel_2.m4a": "eceec56850836dce9a54f8d8e695b189",
"assets/assets/voice/darknightprincess/cough.mp3": "333a58f4a38f0f374cd5536bbe740335",
"assets/assets/voice/darknightprincess/ah.mp3": "238ff871dcd2332ef5c87f5eb9677aac",
"assets/assets/voice/darknightprincess/giggle2.mp3": "60fe38d8588e32878d9bd84070ccbf10",
"assets/assets/voice/darknightprincess/woah.mp3": "805f85f7ffdd83bd146cbcf558bfdcd1",
"assets/assets/voice/darknightprincess/sign.mp3": "fa97eeb3449e8ea779ec7331d442fa0c",
"assets/assets/voice/darknightprincess/oh.mp3": "40806e772c93ea3405d57a07ee628b03",
"assets/assets/voice/darknightprincess/giggle1.wav": "29d89b462c5bbb3fc21307907a153468",
"assets/assets/item/misc/document.png": "f88f7d62f6b7b8abad340d2145d1d57a",
"assets/assets/item/misc/chess_black_pawn.png": "0183afbf7ef14773b86ad74bb11642a3",
"assets/assets/item/misc/book.png": "a19625ff246d6eefee021511b3b0106b",
"assets/assets/item/misc/chess_white_king.png": "c891bfdb06a17ff33917aebe4950c86a",
"assets/assets/item/misc/chess_black_knight.png": "083c881dd9bd0d703e6e6ae783a37434",
"assets/assets/item/misc/chess_white_knight.png": "5abec5a12ac0c2de5d25cc55286c8b9d",
"assets/assets/item/misc/card_diamond.png": "6124092994a3d43f514b1a2a6c724abb",
"assets/assets/item/misc/card_heart.png": "7980d60b6ac5af1e99e43e1649614510",
"assets/assets/item/misc/map.png": "6d874e9c2fb585d2f252ef2a1c693bb4",
"assets/assets/item/misc/chess_white_rook.png": "f7555d5860bc75b84edec3bd598422ca",
"assets/assets/item/misc/chest.png": "2e4b4544e7f7bffa64113ec685cd450d",
"assets/assets/item/misc/card_spade.png": "f24db8d5f766d2b1b15bfe15681338b7",
"assets/assets/item/misc/tinderbox.png": "1773171d96c15a82954e945b1c621d7d",
"assets/assets/item/misc/chess_white_pawn.png": "790161c21636e763cd68bd3e21d9263b",
"assets/assets/item/misc/cup.png": "18b5239c362e6f86917a697020803b6b",
"assets/assets/item/misc/chess_white_queen.png": "f128e386c0ede1704b17b4042d31f71b",
"assets/assets/item/misc/chess_black_king.png": "1507ec72b1b18a945d72dd0549605c61",
"assets/assets/item/misc/grain.png": "54f350ad723c5a1e39e5cb2a60a542dc",
"assets/assets/item/misc/chess_black_queen.png": "737136f6e11024b6a5e37084aadfc453",
"assets/assets/item/misc/chess_white_bishop.png": "77d725b294ba19620cc76023fd80c03c",
"assets/assets/item/misc/chess_black_bishop.png": "5bb5f77311730e4bc33ddbf42ef871bb",
"assets/assets/item/misc/bucket.png": "fc32c961748bcf47988f947ad6418819",
"assets/assets/item/misc/chess_black_rook.png": "21d436b32a8e7beab4ea1d36f0c94a6e",
"assets/assets/item/misc/scroll.png": "f96178c69541c14bafa612dc0f8ff82f",
"assets/assets/item/misc/card_club.png": "81fbded0f7e8686efd1e3572ee478303",
"assets/assets/item/misc/card_back.png": "e8ea864d7d48490fe813e3829bf7ed2e",
"assets/assets/item/misc/bag.png": "28293f830c3fb3358887ca91e965f1cc",
"assets/assets/item/misc/signature.png": "3d54878d0635ed3b2370af79fcdcc253",
"assets/assets/item/weapon/shield_square_iron.png": "1f2909c390013b7593868aa1a7f8da54",
"assets/assets/item/weapon/dagger_bronze.png": "49e3900d4eba27f78e2ea36faa824677",
"assets/assets/item/weapon/staff_nature_oak.png": "8f3b1abd7183c9517a800ac4ad26ac85",
"assets/assets/item/weapon/scimitar_bronze.png": "f49e20b448ba129ed2393372a2106d84",
"assets/assets/item/weapon/flail_iron.png": "4000a9722733bad426581f4403bd84e2",
"assets/assets/item/weapon/mace_bronze.png": "edbba07d2b3974d958304b4ab7805248",
"assets/assets/item/weapon/shield_kite_bronze_1.png": "1566d07fe511be5b681e9799ccdfe71f",
"assets/assets/item/weapon/halberd_bronze.png": "a0aadf2c4177e46cb7cddc86647c1ecf",
"assets/assets/item/weapon/shield_kite_bronze_2.png": "80b9bb83b0ae9b1ba4267e23c3bd07c6",
"assets/assets/item/weapon/waraxe_bronze.png": "9093bc00b2ebac97d237e2cc57ecf238",
"assets/assets/item/weapon/shield_kite_iron_2.png": "0aeb79a20efc045af90718959eb55e00",
"assets/assets/item/weapon/spade.png": "8d0bf7d32168e36a73f0ee6a0f148c0d",
"assets/assets/item/weapon/shield_kite_iron_1.png": "4361a1f0ab2c00073dfe0a9b181d1a13",
"assets/assets/item/weapon/halberd_iron.png": "26422112abc0684c0a7bd4b628cf3a00",
"assets/assets/item/weapon/boomerang_oak.png": "99af7e52151af6314d07e66d6e02676d",
"assets/assets/item/weapon/fishing_rod.png": "f581e55433b9cbcf822572fb758e2780",
"assets/assets/item/weapon/spear_iron.png": "dfdcc8f44515b27f5c7ed820a57abfb0",
"assets/assets/item/weapon/club_willow.png": "cb49d0a41919325d3359d1f6629b3f1b",
"assets/assets/item/weapon/whip.png": "80d195d5c7611444d6d8b38310df0f56",
"assets/assets/item/weapon/bomb_expert.png": "0d158de31c4c7f4ced75cab2a9d8468b",
"assets/assets/item/weapon/staff_elemental_water.png": "f487fc10440343065155c3b2aabe466b",
"assets/assets/item/weapon/shears.png": "ce562dfe3a1d7d0dafc28652d192486f",
"assets/assets/item/weapon/staff_regular_willow.png": "ad7dab8c3fcc900004292c3a8338d499",
"assets/assets/item/weapon/flail_bronze.png": "6478d30f24b8b402a13261951ced11c7",
"assets/assets/item/weapon/pitchfork_iron.png": "23ba1cdfcd9bd22c7d7710dd840dd43a",
"assets/assets/item/weapon/shield_willow.png": "64a6c3662cff66e3b04ff9a300a6f190",
"assets/assets/item/weapon/bomb_basic.png": "00c77591b1beedd9f0b76f5d69548683",
"assets/assets/item/weapon/arrow_iron.png": "2c9eb234ff7defad3a40ad008852985c",
"assets/assets/item/weapon/shield_oak.png": "188accf9ab4354530874f7258f53abfa",
"assets/assets/item/weapon/sword_iron.png": "1f48676f28a8510debe82f6e3f929967",
"assets/assets/item/weapon/crossbow_oak.png": "a45d118cd31467ecb24477d0904d5686",
"assets/assets/item/weapon/pitchfork_bronze.png": "7c68d8a416e1ef4b4c38a62fbb2890a5",
"assets/assets/item/weapon/staff_enhanced_willow.png": "2f276019aa3cd89201ebb4d5266b180f",
"assets/assets/item/weapon/mace_iron.png": "1bee8a4c57f9933f2b4faeadb3ea3a8b",
"assets/assets/item/weapon/staff_regular_oak.png": "0f902fd5449ed8131aa2855a0e9e3f06",
"assets/assets/item/weapon/bow_oak.png": "5149a7f2312a79b853f52d61835d7803",
"assets/assets/item/weapon/warhammer_bronze.png": "aad70e32442a030d62daea5c2cc708f6",
"assets/assets/item/weapon/wand_willow.png": "029b4e9f90dac51d82e744c8c507ee00",
"assets/assets/item/weapon/sword_practice_oak.png": "ae6857c94205c14f7d518e712b66b2be",
"assets/assets/item/weapon/scimitar_iron.png": "603518c0269a5e5d6e57bd8a65b6336f",
"assets/assets/item/weapon/spear_bronze.png": "03d69dd77073ccc7ce8780ebd0902e1f",
"assets/assets/item/weapon/staff_elemental_air.png": "e57439c3bdfd017f501d6167403ba340",
"assets/assets/item/weapon/club_oak.png": "494230efd8e30fbe6bf19fc8781d6955",
"assets/assets/item/weapon/knife_bronze.png": "375eeca3dc790d2c5de49a221145fd87",
"assets/assets/item/weapon/bow_willow.png": "752f7cfc120676b9f7ee6516fdcf43cf",
"assets/assets/item/weapon/wand_oak.png": "8ee96cd991877243db8758b42dc00f5f",
"assets/assets/item/weapon/axe.png": "7fa491d742a9d6125378003919c05e7c",
"assets/assets/item/weapon/knife_iron.png": "77c6e8aa77969d00f683742261d04fda",
"assets/assets/item/weapon/staff_elemental_earth.png": "a84763225c4ef32e1793734d54311c49",
"assets/assets/item/weapon/sword_practice_willow.png": "8fc6ad59696bcac14d3ff6ffaa2021bb",
"assets/assets/item/weapon/arrow_bronze.png": "3a9bcc146aac4cdf38906703a15ea1ea",
"assets/assets/item/weapon/crossbow_willow.png": "58de20a6f0e5598d732cebb0d74cbd44",
"assets/assets/item/weapon/hammer.png": "3ebe45ce447b7cc1057dd9fe0b8a1250",
"assets/assets/item/weapon/staff_elemental_fire.png": "b9653dc7c7fc35fb81dbfda0c7e9412a",
"assets/assets/item/weapon/boomerang_willow.png": "707088f115987cecf437020aa53c3ea9",
"assets/assets/item/weapon/shield_square_bronze.png": "c2fffb76ec45cffb666f7022720a6bc1",
"assets/assets/item/weapon/sword_bronze.png": "78b6206afc87648a9a2fb2aeac815c73",
"assets/assets/item/weapon/pickaxe.png": "c533f0c22e5db9c0f161126a0a54a7f2",
"assets/assets/item/weapon/staff_enhanced_oak.png": "83266d35442792a770df5074afe9b0ab",
"assets/assets/item/weapon/staff_nature_willow.png": "140bcc70491069e453745f0a8057d934",
"assets/assets/item/weapon/waraxe_iron.png": "8b6e17eb078235e2702b7fd1fedd9b41",
"assets/assets/item/weapon/warhammer_iron.png": "507d6b2a02a37de20befef0a2fc997de",
"assets/assets/item/weapon/dagger_iron.png": "2b9a21aed05c6c3a809ba5dfa8674c6e",
"assets/assets/item/skill/spell_shield_superior.png": "b001e75a1e5b88cc2f858c747a88efe1",
"assets/assets/item/skill/spell_darkness_superior.png": "91e4e97b3ae35494ac7cc7924bf0c85f",
"assets/assets/item/skill/spell_skull_minor.png": "816d3ea90e6c283112afc289a138214a",
"assets/assets/item/skill/spell_sword_minor.png": "27b051c03a63e4a8d6d7e5c62535159b",
"assets/assets/item/skill/spell_darkness_major.png": "ac2ff9ef7bae34e85adfa2667cb17d21",
"assets/assets/item/skill/spell_mystic_superior.png": "8067ac0da165f2f229156dfd16d67061",
"assets/assets/item/skill/spell_wind_minor.png": "3831e970074134e45c9a6d5dc8cc0470",
"assets/assets/item/skill/spell_heart_minor.png": "3f2c6b8fe10d75288b9cc59b00b58b91",
"assets/assets/item/skill/spell_water_major.png": "bbed407136d2126962f3a2ec6ba91d80",
"assets/assets/item/skill/spell_bones_superior.png": "269689695e9b344fb9dd7ad4779b04df",
"assets/assets/item/skill/spell_sand_major.png": "205934e9c988ff88a3de646f333497c3",
"assets/assets/item/skill/spell_wind_superior.png": "192e13f4cb1e334d5457b760931ec9c5",
"assets/assets/item/skill/spell_mystic_minor.png": "c6aa41ccea43babd3e0bdd78cb4ec166",
"assets/assets/item/skill/spell_heart_superior.png": "4cbb1eb4f1fcc80a8706098a137962f4",
"assets/assets/item/skill/spell_sword_major.png": "29e2b697f8b09ecf58f59714e17f024a",
"assets/assets/item/skill/spell_darkness_minor.png": "3289a2cfef14df9618305917cc61feac",
"assets/assets/item/skill/spell_wind_major.png": "650ac526052cc15e68fde9519171f17b",
"assets/assets/item/skill/spell_heart_major.png": "49106090f79a288071c70e50a610f4ca",
"assets/assets/item/skill/spell_skull_major.png": "8c471b2b52db88041a41d21558685040",
"assets/assets/item/skill/spell_light_superior.png": "91b153c27dde5f8c05c446213f9f4e33",
"assets/assets/item/skill/spell_mystic_major.png": "826f2cb09032c48d555e4d471457be1d",
"assets/assets/item/skill/spell_gem_superior.png": "c1eef0b8277e7d822d4d71b52d615d9a",
"assets/assets/item/skill/spell_water_minor.png": "a2d5a4895b2da942bbe4516ac74986a9",
"assets/assets/item/skill/spell_skull_superior.png": "92b73efabc9e4ccfd8d1a45498d61786",
"assets/assets/item/skill/spell_sand_minor.png": "bedb6b4f4340942b5499e15cc9184e9f",
"assets/assets/item/skill/spell_nature_minor.png": "5022b565edd3b2083a51be3909227596",
"assets/assets/item/skill/spell_earth_major.png": "957e19eec2fb90a545dedfbde15641b7",
"assets/assets/item/skill/spell_earth_superior.png": "f6e401786b762f5eabcca90ece1c70f7",
"assets/assets/item/skill/spell_gem_major.png": "88647ccf410642243a1799fc2783bf89",
"assets/assets/item/skill/spell_regeneration_minor.png": "3d7ec13d073f4a202061173c6c6318ed",
"assets/assets/item/skill/spell_light_minor.png": "e243598bc63fd2fb8a7eab5e9e5ac29e",
"assets/assets/item/skill/spell_bones_minor.png": "abc98758ec5c4db261da15cf98c27058",
"assets/assets/item/skill/spell_sand_superior.png": "0c5d5b0cca9b5dd7fd8c21850fbb331b",
"assets/assets/item/skill/spell_fire_minor.png": "ad67d0ca2177fc26ee2880bf6854adf5",
"assets/assets/item/skill/spell_shield_major.png": "8f100a886853b6c6823d4a225b16d333",
"assets/assets/item/skill/spell_gem_minor.png": "736060286c485e13352d9683fdaf0613",
"assets/assets/item/skill/spell_regeneration_major.png": "e88f9c24bd7964423a05976e2101e587",
"assets/assets/item/skill/spell_light_major.png": "428243e26db4342dd1fd66c1d85b50ca",
"assets/assets/item/skill/spell_nature_superior.png": "3cc04bbf308bb74bd24d659f71e8ac8c",
"assets/assets/item/skill/spell_fire_superior.png": "7e59b35643070e22dfb77e14c2ad439e",
"assets/assets/item/skill/spell_nature_major.png": "e7809b98e3e0ea14410e6f0e4c2ee494",
"assets/assets/item/skill/spell_earth_minor.png": "0163c9fd4e8a0a256bc1c1525cd892b7",
"assets/assets/item/skill/spell_water_superior.png": "b393ab38cdaf2cf623decb9e090a2ea4",
"assets/assets/item/skill/spell_fire_major.png": "f7499cb889bdaaa538228293c46dd336",
"assets/assets/item/skill/spell_shield_minor.png": "1285d909b5600f11f45241f00408ae5d",
"assets/assets/item/skill/spell_bones_major.png": "49c8d7ac44288d0c4ee1bc302f92431b",
"assets/assets/item/skill/spell_sword_superior.png": "207bc74cfcf9c5372ce6069e686981f8",
"assets/assets/item/skill/spell_regeneration_superior.png": "feea0c1f9046c14fe174680f98beeb33",
"assets/assets/item/equipable/amulet_sapphire.png": "dec86ff510844c8d1443ffd867fedf5d",
"assets/assets/item/equipable/scabbard.png": "51c6b984e45306ffb976252c5ddc7e81",
"assets/assets/item/equipable/helmet_heavy_bronze.png": "45b211ce13da51fe9ff89d555956fd74",
"assets/assets/item/equipable/ring_emerald.png": "d795827a2103e3c810cf10d5af74bbd3",
"assets/assets/item/equipable/plate_armor_bronze.png": "33e9418774493bab9ddbcaf8afcb2de4",
"assets/assets/item/equipable/coif.png": "9530699bcd0de44db608abbd08a78986",
"assets/assets/item/equipable/amulet_diamond.png": "7478357711d2589e49d5d0356327d5a0",
"assets/assets/item/equipable/helmet_royal_iron.png": "efa041a0d3839c3dc4245d327ed7b5a9",
"assets/assets/item/equipable/ring_sapphire.png": "68added8b73ddc09da3a194acf1ce91b",
"assets/assets/item/equipable/backpack.png": "1d4388e18a75646f54b60c45543f1ec4",
"assets/assets/item/equipable/helmet_light_bronze.png": "45439959b5d058a7a629814e887ac2ed",
"assets/assets/item/equipable/amulet_ruby.png": "7206739b6ce6416ab23320a069cdf994",
"assets/assets/item/equipable/amulet_emerald.png": "2f3fede563784cb998519ea023879867",
"assets/assets/item/equipable/monster_slayer_helmet.png": "f0ef2ce9329c8dc1cb4198be7be98f74",
"assets/assets/item/equipable/helmet_light_iron.png": "6e5d842d0ec5bc2adf46d4d815d0909d",
"assets/assets/item/equipable/ring_diamond.png": "b6df77239f6523f71df64b41f7e98148",
"assets/assets/item/equipable/chainmail_bronze.png": "c3069d5f3840e34627fec084739e7f7d",
"assets/assets/item/equipable/plate_armor_iron.png": "dbe34fab9388a549ca25a942a9ea5e73",
"assets/assets/item/equipable/helmet_royal_bronze.png": "3025cd8c8bda122b440bc6dfef7151b3",
"assets/assets/item/equipable/boot.png": "6d6266e360a66256c4d4fbe02f352ac1",
"assets/assets/item/equipable/helmet_heavy_iron.png": "485a6b3c12fd0f82d5c164a1f5dfbe2b",
"assets/assets/item/equipable/chainmail_iron.png": "4247225a1b585434d5da851830d5134e",
"assets/assets/item/equipable/crown.png": "f85e10473d891a4b596037d3ef61ea05",
"assets/assets/item/equipable/ring_ruby.png": "dd871f1f2ce07e5403900056a6a7f563",
"assets/assets/item/consumable/potion_green_medium.png": "4f42011396ebfa1b91c5be427dd02907",
"assets/assets/item/consumable/potion_yellow_small.png": "819945d4c63bf8e2e767f8dae3dc11d6",
"assets/assets/item/consumable/bread.png": "266f60e2cca665b84985edf57ff2da91",
"assets/assets/item/consumable/potion_green_small.png": "53262cba042bd5d0585e5b08e018f928",
"assets/assets/item/consumable/potion_blue_small.png": "cd974936664429260782ecda0740175d",
"assets/assets/item/consumable/carrot.png": "303635138a8770129de8b7c13e2460b9",
"assets/assets/item/consumable/potion_black_medium.png": "1a9b58780a60c3c40ba7e8760c637909",
"assets/assets/item/consumable/potion_black_small.png": "725c98c3913a6c9a6bf6412cf1b2e063",
"assets/assets/item/consumable/chicken.png": "869324e71d83d5d2b231a2c1e1b6356d",
"assets/assets/item/consumable/shrimp.png": "e8ee97ea26342a3ac8f721225b91f137",
"assets/assets/item/consumable/potion_yellow_big.png": "7a5e466138a03b3d82f5d47526d08d47",
"assets/assets/item/consumable/beef.png": "299fffee122a79347d14aa3e5389e5ad",
"assets/assets/item/consumable/potion_yellow_medium.png": "b43823ade1f277f35da2a36d99428bac",
"assets/assets/item/consumable/potion_blue_big.png": "8439bed33bd7e8ae94a758e6faaabbc6",
"assets/assets/item/consumable/potion_red_big.png": "bf000e35e914384e4965abeab5757790",
"assets/assets/item/consumable/potion_blue_medium.png": "5791055b9079633da894cce3c7f343ad",
"assets/assets/item/consumable/potion_red_small.png": "326d86dbe0403738933e2edcf1afa71e",
"assets/assets/item/consumable/banana.png": "db005650300c72d3abf0f34742fd6b40",
"assets/assets/item/consumable/potion_red_medium.png": "8b46c253e36dcc78887c7f1499210a24",
"assets/assets/item/consumable/apple_green.png": "be6078dabbbe672333b2a8cad37a30ba",
"assets/assets/item/consumable/berries.png": "cacf0a92488e8baeded69d69c71d943f",
"assets/assets/item/consumable/apple_red.png": "9ff0652f30a5f8ac80e64c99349c57a3",
"assets/assets/item/consumable/potion_green_big.png": "2616f2c8b27dd84d669d41025e86b6cc",
"assets/assets/item/consumable/potion_black_big.png": "058557f54300087115a909bc8162d850",
"assets/assets/item/resource/mushroom.png": "089a70fb8a1f0dd783d0472581546464",
"assets/assets/item/resource/bar_iron_2.png": "f9b6c406dbf706e1bdd723119739039f",
"assets/assets/item/resource/ruby_2.png": "456104257f57ecfab2359207614016ed",
"assets/assets/item/resource/bar_iron_1.png": "ec15d899e6a48d298b199d34da53b8a1",
"assets/assets/item/resource/ruby_1.png": "066136e6f5a6fe15cf6552737eccafdb",
"assets/assets/item/resource/skull.png": "7f931968b7edba496303531b39dc42e9",
"assets/assets/item/resource/log_oak_2.png": "42f5c1831e734afe573b8581c7c81bd4",
"assets/assets/item/resource/log_oak_1.png": "f47356601017a7d9c7f3f4dd1466bb4b",
"assets/assets/item/resource/key.png": "c4580c9ab69c52df1b77e295ee42c659",
"assets/assets/item/resource/sapphire_1.png": "360656f217e319bb46709a1e48b5ad13",
"assets/assets/item/resource/sapphire_2.png": "14a83161cfcb8c4936d457c01c110840",
"assets/assets/item/resource/dogecoin.png": "fba992f73982e2535a9b31268c73dc99",
"assets/assets/item/resource/diamond_2.png": "af17f08e75fa670e174b328b8d736387",
"assets/assets/item/resource/coin_copper_1.png": "991d1116608878fdf1b696f4091af387",
"assets/assets/item/resource/emerald_2.png": "bf992706ed91f945a449b6213aca8363",
"assets/assets/item/resource/log_willow_1.png": "3d8f7d342e6422e0558fcd2a9b9fc502",
"assets/assets/item/resource/diamond_1.png": "d3747138b8b465cf4594a2af00f22c92",
"assets/assets/item/resource/monster_skull.png": "a1493c108a0cd9f791d714d7bf86f18c",
"assets/assets/item/resource/coin_copper_2.png": "e53e86fd91b18045e4103c6139d4d778",
"assets/assets/item/resource/emerald_1.png": "42b058ba9de3c1c5148c0e3e7a69ee1d",
"assets/assets/item/resource/log_willow_2.png": "f5da5f17b6a79917e89c78ac1a459f7b",
"assets/assets/item/resource/bar_bronze_2.png": "3757320b81593aa66ced7114d89e7703",
"assets/assets/item/resource/coin_silver_2.png": "5f17359eee5c6e8498d95981f9014991",
"assets/assets/item/resource/coin_silver_1.png": "36e10b2e624d45928378dd781a9706e7",
"assets/assets/item/resource/bar_bronze_1.png": "8d7bd6ab99cb8bb199e1d1d159596e30",
"assets/assets/item/resource/ore_tin_4.png": "1d334c8c171fa3da3ece664f31822a41",
"assets/assets/item/resource/wool.png": "ed6b5923ee099b8ba1da8be0041b1d3c",
"assets/assets/item/resource/coin_gold_1.png": "509437defe8bb0887870fc5bc5cdea62",
"assets/assets/item/resource/ore_tin_1.png": "8e63867c5057d3aa44c356d8b28d49c7",
"assets/assets/item/resource/ore_tin_3.png": "39a796fa08dee03415c5951b4c70770c",
"assets/assets/item/resource/coin_gold_2.png": "311d96d3377b981da92704c08d922ba8",
"assets/assets/item/resource/ore_tin_2.png": "175772696eca4ced6542f904bb028101",
"assets/assets/item/resource/ore_coal_2.png": "2a905eb696f0951b99144865de851de9",
"assets/assets/item/resource/bones.png": "1e7492f1336afd9c7d3e6ff9955e36c4",
"assets/assets/item/resource/ore_iron_1.png": "3fb4641576e2d34d5eedf829d62f7a77",
"assets/assets/item/resource/ore_coal_3.png": "89bf502a71161b6a5d127ad4312e89ac",
"assets/assets/item/resource/ore_coal_1.png": "7da9cb58584654aee6fdc76c57bd02b9",
"assets/assets/item/resource/feather.png": "41c3bb97dd9d50725b68912f83273f53",
"assets/assets/item/resource/ore_iron_3.png": "94387d7f6c22f9e829c4940807a64186",
"assets/assets/item/resource/ashes.png": "2c86e3e07dca742f43a7fa8c44b645e5",
"assets/assets/item/resource/egg.png": "5f71ffc05c801a369f71fecdc51eab10",
"assets/assets/item/resource/ore_iron_2.png": "952a85f57dbbc1c50692365c72f08d53",
"assets/assets/item/resource/ore_coal_4.png": "4681571112f99b80285a9134910629af",
"assets/assets/item/resource/seeds.png": "0be05a3005c8d1946d2d4eaa907e3588",
"assets/assets/item/resource/fur.png": "98b6d0dc5ce9d6562096dde083e7415e",
"assets/assets/item/resource/horn.png": "a575439cc624ad2c24deb0f3473906e5",
"assets/assets/item/resource/fangs.png": "6707554a11d0d9c425fa195af2397174",
"assets/assets/item/resource/fish.png": "3e2c244e04f5f4456d55ae0f17e09bf1",
"assets/assets/item/resource/ore_iron_4.png": "f25d36a9e11263d47c7e55e214ef4ea5",
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
"assets/assets/sound/slime1.mp3": "446b0c6c836db48e94f63f72f2930184",
"assets/assets/sound/shwoosh_hit.m4a": "f791bbef710954988f2fd3531f0e9296",
"assets/assets/sound/slime2.wav": "694e36810ffdcbd4f58ece32f58bf2a8",
"assets/assets/sound/shu-shu-equip.m4a": "5f9adcb51e4c3c3a2dec4233b570144d",
"assets/assets/sound/click-clack.m4a": "7901358bbc7071267bc7e5bcd494bf36",
"assets/assets/monster/slime/Green%2520Slime.png": "7f7a9651133ef4025f42aa2d3189d658",
"assets/assets/monster/slime/Planet%2520Slime.png": "bc42d48d83c64742de78d72a8b77fae1",
"assets/assets/monster/slime/Ice%2520Slime-chan.png": "52deede790661f64b14cefc103cff638",
"assets/assets/monster/slime/Money%2520Slime.png": "de5dc19870ee89c38b868ef0060de66a",
"assets/assets/monster/slime/Chicken%2520Slime.png": "c70d5d0aae885671ba7fa4d3750c6e4a",
"assets/assets/monster/slime/Thunder%2520Slime.png": "1243d9f7fcd6c5e91bc5da05792d799b",
"assets/assets/monster/slime/Gold%2520Slime.png": "b230161025d2f3b063e401b1d48b8dad",
"assets/assets/monster/slime/Dirt%2520Slime-chan.png": "fe618dfc1bc6e7b6f047036c5d694581",
"assets/assets/monster/slime/Dendro%2520Slime.png": "213582d0895c17b38783a6cc8c38302c",
"assets/assets/monster/slime/Flying%2520Slime-chan.png": "ee1538e01eb13f628b12486630499445",
"assets/assets/monster/slime/Fire%2520Slime.png": "937249652ff08716b04af1896ce07e1f",
"assets/assets/monster/slime/Lava%2520Slime-chan.png": "820b5dd053656863281942d9c556dcac",
"assets/assets/monster/slime/Red%2520Slime.png": "e904708b5148317caca269326c86de91",
"assets/assets/monster/slime/Red%2520Long%2520Slime.png": "390345787c0253b0725fd770b29222ff",
"assets/assets/monster/slime/Gem%2520Slime.png": "74442f497aa64948de9366d630e09b16",
"assets/assets/monster/slime/Slime%2520Group.png": "8aae4a297083a2a4333b481a41386051",
"assets/assets/monster/slime/Ice%2520Slime.png": "235d3a2acf1a64590814ef3db96da0fb",
"assets/assets/monster/slime/Spark%2520Slime.png": "aeef7ed7f7c1b7be5c017e6b5a41d824",
"assets/assets/monster/slime/Cat%2520Slime-chan.png": "852b71408c43bc1971c49db073818cee",
"assets/assets/monster/slime/Venom%2520Slime.png": "b024c806048061592a4bcdc2068de35e",
"assets/assets/monster/slime/Octopus%2520Slime.png": "33713373bda2766c377c3c050ebe1493",
"assets/assets/monster/slime/Goo%2520Slime.png": "af7f00af6c471021b9afe510dd7ec785",
"assets/assets/monster/slime/Dirt%2520Slime.png": "c948f536625f77156b85b72e2a23de04",
"assets/assets/monster/slime/Blue%2520Slime.png": "a51972fb1c730253cb74be7f7770ed8a",
"assets/assets/monster/slime/Cat%2520Slime.png": "3f95ed05d7d69c270505cab6b15cc560",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
