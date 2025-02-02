import { Controller } from "@hotwired/stimulus"
import L from "leaflet"

export default class extends Controller {
    connect() {
        this.initializeMap()
        this.loadMarkers()
    }

    // Initialize the map using provided center data or defaults
    initializeMap() {
        const centerLat = parseFloat(this.data.get('centerLat')) || 54.0
        const centerLon = parseFloat(this.data.get('centerLon')) || -2.0
        this.map = L.map(this.element).setView([centerLat, centerLon], 11)
        L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
            attribution: "Map data © OpenStreetMap contributors",
            maxZoom: 19
        }).addTo(this.map)
    }

    // Fetch conservation sites and add markers to the map
    loadMarkers() {
        fetch('/wildlife_locations.json')
            .then(response => response.json())
            .then(data => {
                if (data.length === 0) {
                    const msgDiv = document.getElementById('map-message')
                    if (msgDiv) { msgDiv.innerText = "No conservation sites found nearby." }
                }
                data.forEach(site => {
                    L.marker([parseFloat(site.latitude), parseFloat(site.longitude)])
                        .addTo(this.map)
                        .bindPopup(site.name)
                })
            })
    }
}
