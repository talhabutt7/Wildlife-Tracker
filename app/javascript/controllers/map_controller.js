// import { Controller } from "@hotwired/stimulus"
// import L from "leaflet"
//
// export default class extends Controller {
//   static values = { sites: Array } // Expects JSON data of sites
//
//   connect() {
//     // Initialize Leaflet map
//     this.map = L.map(this.element).setView([51.505, -0.09], 13)
//     L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(this.map)
//
//     // Add markers from data
//     this.addMarkers()
//   }
//
//   addMarkers() {
//     this.sitesValue.forEach(site => {
//       const [lng, lat] = site.coordinates.replace(/SRID=4326;POINT\(|\)/g, '').split(' ')
//       L.marker([lat, lng]).addTo(this.map).bindPopup(site.name)
//     })
//   }
// }

// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  connect() {
    this.initializeMap()
    this.loadMarkers()
  }

  initializeMap() {
        // Initialize Leaflet map
    this.map = L.map(this.element).setView([51.505, -0.09], 12)
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(this.map)
  }

  loadMarkers() {
    fetch('/wildlife_locations.json')
        .then(response => response.json())
        .then(data => {
          data.forEach(site => {
            L.marker([parseFloat(site.latitude), parseFloat(site.longitude)])
                .addTo(this.map)
                .bindPopup(site.name)
          })
        })
  }
}
