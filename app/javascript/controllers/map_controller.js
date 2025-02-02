import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
  connect() {
    this.initializeMap()
    this.loadMarkers()
      window.addEventListener('marker:added', event => {
          const { latitude, longitude, name } = event.detail
          L.marker([parseFloat(latitude), parseFloat(longitude)])
              .addTo(this.map)
              .bindPopup(name)
      })
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
