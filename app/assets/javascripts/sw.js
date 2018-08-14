const applicationServerPublicKey = 'BLC8FDoQ4_xHUpyMhDUSSX4pyB5wlH16wiH3-jgMm2GfJGO0fs10CfVgEA8ZALw1HoyGbN32BqL5f0AnXPRHbgw'
const applicationServeryPrivateKey = 'k_bZJEAt8XyT-DfQLs2gyzJhe2Vbjn6UnlneiPLi-ho'

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

function updateSubscriptionOnServer(subscription) {
  // TODO: Send subscription to application server

  // const subscriptionJson = document.querySelector('.js-subscription-json');
  // const subscriptionDetails = document.querySelector('.js-subscription-details');

  if (subscription) {
    // subscriptionJson.textContent = JSON.stringify(subscription);
    // subscriptionDetails.classList.remove('is-invisible');
    console.log('subscribed ',subscription);
  } else {
    // subscriptionDetails.classList.add('is-invisible');
    console.log('did not subscribe')
  }
}

function subscribeUser(swReg, userId) {
  const applicationServerKey = urlB64ToUint8Array(applicationServerPublicKey);
  swReg.pushManager.subscribe({
    userVisibleOnly: true,
    applicationServerKey: applicationServerKey
  }).then(function(subscription) {
    console.log('User is subscribed.');
    updateSubscriptionOnServer(subscription, userId);
    isSubscribed = true;
  }).catch(function(err) {
    console.log('Failed to subscribe the user: ', err);
  });
}
