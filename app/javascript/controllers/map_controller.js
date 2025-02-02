// app/javascript/controllers/map_controller.js
import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
    connect() {
        this.initializeMap()
        this.loadMarkers()
    }

    initializeMap() {
        const centerLat = parseFloat(this.data.get('centerLat')) || 54.0
        const centerLon = parseFloat(this.data.get('centerLon')) || -2.0
        this.map = L.map(this.element).setView([centerLat, centerLon], 13)
        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution: "Map data © OpenStreetMap contributors",
            maxZoom: 19
        }).addTo(this.map)
    }

    loadMarkers() {
        fetch('/wildlife_locations.json')
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    const msgDiv = document.getElementById('map-message')
                    if (msgDiv) {
                        msgDiv.innerText = "No conservation sites found in that area."
                    }
                }
                data.forEach(site => {
                    L.marker([parseFloat(site.latitude), parseFloat(site.longitude)])
                        .addTo(this.map)
                        .bindPopup(site.name)
                })
            })
    }
}
