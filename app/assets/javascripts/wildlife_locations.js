document.addEventListener('turbo:load', function() {
    var mapEl = document.getElementById('map');
    if (!mapEl) return;
    var map = L.map('map').setView([51.505, -0.09], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: 'Map data © OpenStreetMap contributors'
    }).addTo(map);
    fetch('/wildlife_locations.json')
        .then(response => response.json())
        .then(function(data) {
            data.forEach(function(loc) {
                L.marker([parseFloat(loc.latitude), parseFloat(loc.longitude)])
                    .addTo(map)
                    .bindPopup(loc.name);
            });
        });
});