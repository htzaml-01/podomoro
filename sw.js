/* Service worker: membuat aplikasi bisa dibuka tanpa internet. */
const CACHE = 'fokus-shell-v1';
const FONTS = 'fokus-fonts-v1';
const SHELL = [
  './', 'index.html', 'admin.html', 'manifest.webmanifest',
  'icons/icon.svg', 'icons/icon-192.png', 'icons/icon-512.png',
  'icons/maskable-512.png', 'icons/apple-touch-icon.png'
];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(SHELL)).then(() => self.skipWaiting()));
});

self.addEventListener('activate', (e) => {
  e.waitUntil(
    caches.keys()
      .then((keys) => Promise.all(keys.filter((k) => k !== CACHE && k !== FONTS).map((k) => caches.delete(k))))
      .then(() => self.clients.claim())
  );
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);

  if (url.origin === self.location.origin) {
    if (req.mode === 'navigate') {
      // Halaman: ambil versi terbaru bila online, jika tidak pakai salinan tersimpan.
      e.respondWith(
        fetch(req)
          .then((r) => {
            if (r.ok) { const copy = r.clone(); caches.open(CACHE).then((c) => c.put('index.html', copy)); }
            return r;
          })
          .catch(() => caches.match('index.html'))
      );
      return;
    }
    e.respondWith(
      caches.match(req).then((hit) => hit || fetch(req).then((r) => {
        if (r.ok) { const copy = r.clone(); caches.open(CACHE).then((c) => c.put(req, copy)); }
        return r;
      }))
    );
    return;
  }

  if (url.hostname === 'fonts.googleapis.com' || url.hostname === 'fonts.gstatic.com') {
    e.respondWith(
      caches.open(FONTS).then((c) => c.match(req).then((hit) =>
        hit || fetch(req).then((r) => { c.put(req, r.clone()); return r; }).catch(() => hit)
      ))
    );
  }
});
