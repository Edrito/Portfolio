'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "911c9fb5f41ca6199bff3ea5734da704",
"assets/AssetManifest.bin.json": "2ce90c1afb029819e7ca72b53b3cd764",
"assets/AssetManifest.json": "cbd3d06b5b480d32b5509d5b017ad23a",
"assets/assets/icons/nzane.png": "60baff5c45eedd07efc9ea37b71ebead",
"assets/assets/icons/runefire.png": "cd386868cb2083e72c1b3f3c9ae87b84",
"assets/assets/icons/tearawhakaora.png": "7f9aed38ed4446198ec136f08986a986",
"assets/assets/icons/whispers.png": "8ea91f3d15b822e5d7eaf0bcf94d181f",
"assets/assets/items/items.json": "403087185191980e203ac05bff27beff",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "aa33cc437178ff87cf286ed58602f830",
"assets/NOTICES": "a2218c8fc0ffd943f95c634c42ad4637",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "22e262fddd303d7f8e5817faac030756",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"images/nzane/1.png": "31fdc60ce359d9d501a2f1a55cdbe493",
"images/nzane/2.png": "66268ed6cda7508130d30bb9e0eb2000",
"images/nzane/3.png": "136896e86fff1be40c9c2fd5689e50f3",
"images/nzane/4.png": "e0732ede370d62ad04836382da206f00",
"images/nzane/5.png": "1b4dc96fea7a39e7cd8e0e149e6b964e",
"images/nzane/6.png": "1852aac2c8b55fa019f57be5a596fdeb",
"images/nzane/7.png": "979ca45516dbb8d7a5b0e52046a1e5c3",
"images/nzane/8.png": "ab610098b481959397cb693aae296eff",
"images/nzane/9.jpg": "02d92d8b7691ea28381fdfd561e5d5c5",
"images/nzane/9.png": "23deebe1da7260ed411604e902574436",
"images/runefire/1.png": "95b17389c927d74be0a8279069eb3bc8",
"images/runefire/2.png": "f8316563e0f82766f1c554a07dae6ba1",
"images/runefire/3.png": "59d2c8546552518754a1858e144bfe61",
"images/runefire/4.png": "491c68cb8ca3127db323e91fa2be415d",
"images/runefire/5.png": "d80f6779d569fb5c6bafb288add736a0",
"images/runefire/6.png": "f2da5683f0a95de954761f491d83fa7f",
"images/runefire/7.png": "04b4e494475ff1a5383f2fbe3b0c9500",
"images/runefire/8.png": "6b520a663b72b4b060f39cbc228827e9",
"images/tearawhakaora/1.png": "92da8d68279b114fecdbfe7466256a4c",
"images/tekemuarapu/1.png": "42b4ce6129755391b443b75bceb98c97",
"images/tekemuarapu/2.png": "8f355f79586ffbaa32b1d7fa09cff033",
"images/whispers/1.JPEG": "d58d24f5fbb4f57a434a656584ce772b",
"images/whispers/2.JPEG": "4bf8c31d8cb19017b938a2f431cf3887",
"images/whispers/3.JPEG": "5626e30acbb1ec5c9ca66befff811020",
"images/whispers/4.JPEG": "097aacfbc321e4d44120e8edb78e4486",
"images/whispers/5.JPEG": "1b710ad44cb1d9b0c6552a7c982b34f5",
"images/whispers/6.JPEG": "85f6946370897372ebef9551678085d2",
"index.html": "ef9c4e9463d071cd846e0644684f6a12",
"/": "ef9c4e9463d071cd846e0644684f6a12",
"main.dart.js": "c6466746f98dd903f90cb0e9e0d6b236",
"manifest.json": "34d7a93a24a9edfdcbc76b9763f73a11",
"version.json": "11e1a177d57c5da2bc6e3a6acc3010f4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
