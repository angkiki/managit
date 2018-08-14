const applicationServerPublicKey = 'BLC8FDoQ4_xHUpyMhDUSSX4pyB5wlH16wiH3-jgMm2GfJGO0fs10CfVgEA8ZALw1HoyGbN32BqL5f0AnXPRHbgw'
const applicationServerPrivateKey = 'k_bZJEAt8XyT-DfQLs2gyzJhe2Vbjn6UnlneiPLi-ho'

function urlB64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

function updateSubscriptionOnServer(subscription, p256dhKey, authkey, userId) {
  if (subscription) {
    console.log('subscribed ',subscription);
    console.log('endpoint ',subscription.endpoint);

    const url = '/workers/create/' + userId;
    const worker = {
      worker: {
        endpoint: subscription.endpoint,
        p256: p256dhKey,
        auth: authkey
      }
    }

    const data = {
      method: 'POST',
      body: JSON.stringify(worker),
      headers:{
        'Content-Type': 'application/json'
      }
    };

    fetch(url, data).then( (response) => {
      if (response.status !== 200) {
        console.log('Failed: ', response);
      } else {
        console.log('Success: ', response);
      }
    }).catch( (err) => {
      console.log('Error: ', err);
    });

  } else {
    console.log('did not subscribe')
  }
}

function subscribeUser(swReg, userId) {
  const applicationServerKey = urlB64ToUint8Array(applicationServerPublicKey);

  swReg.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: applicationServerKey
  }).then(function(subscription) {

    console.log( subscription );
    // const p256dhKey = urlB64ToUint8Array( subscription.getKey('p256dh') )
    // const authKey = urlB64ToUint8Array( subscription.getKey('auth') )
    // const p256dhKey = btoa(String.fromCharCode.apply(null, new Uint8Array(subscription.getKey('p256dh')))).replace(/\+/g, '-').replace(/\//g, '_')
    // const authKey = btoa(String.fromCharCode.apply(null, new Uint8Array(subscription.getKey('auth')))).replace(/\+/g, '-').replace(/\//g, '_')
    // const p256dhKey = subscription.getKey('p256dh');
    // const authKey = subscription.getKey('auth');

    const p256dhKey = swReg.keys.p256dh;
    const authKey = swReg.keys.auth;

    console.log('User is subscribed.');
    console.log('p256: ', p256dhKey);
    console.log('auth: ', authKey);

    updateSubscriptionOnServer(subscription, p256dhKey, authKey, userId);

  }).catch(function(err) {
    console.log('Failed to subscribe the user: ', err);
  });
}
