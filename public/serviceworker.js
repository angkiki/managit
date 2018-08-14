self.addEventListener('install', function(event) {
  // Perform install steps
  console.log('install is called');
});

self.addEventListener('push', function(event) {
  console.log('[Service Worker] Push Received.');
  console.log(`[Service Worker] Push had this data: "${event.data.text()}"`);

  const title = 'Push Codelab';
  const options = {
    body: 'Yay it works.'
  };

  // event.waitUntil(self.registration.showNotification(title, options));
  // easier way of writing the above line of code
  const notificationPromise = self.registration.showNotification(title, options);
  event.waitUntil(notificationPromise);
});
