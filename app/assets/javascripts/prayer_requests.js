var prayerRequestSwitch = document.querySelectorAll('#prayerRequestSwitch')[0];

prayerRequestSwitch.addEventListener("click", () => {
  var userPrayerRequests = document.querySelectorAll('.userPrayerRequests');
  var publicPrayerRequests = document.querySelectorAll('.publicPrayerRequests');
  var prayerRequestHeader = document.querySelectorAll('#prayer-request-header')[0];
  var prayerRequestHeaderAlt = document.querySelectorAll('#prayer-request-header-alt')[0];

  userPrayerRequests.forEach(element => 
    element.classList.toggle('hidden')
  );
  publicPrayerRequests.forEach(element => 
    element.classList.toggle('hidden')
  );

  prayerRequestHeader.classList.toggle('hidden');
  prayerRequestHeaderAlt.classList.toggle('hidden');
});
