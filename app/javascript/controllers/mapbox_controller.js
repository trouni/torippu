import { Controller } from "stimulus"
import mapboxgl from 'mapbox-gl';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

const geoapi_url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
const url_append = '.json?access_token=pk.eyJ1Ijoib25pZ2lyaXB3IiwiYSI6ImNqdmoxN2ZnNTBidzI0MGszMWRqbzg4eWcifQ.Kq3ipy7NCPpLWqM49pyY_g'

export default class extends Controller {
  static targets = [ "from", "to" ]

  connect() {
  }

  addFromMarker() {
    const originInput = document.querySelector('#mapbox-directions-origin-input input')
    originInput.value = this.fromTarget.value
    originInput.focus()
    const mapElement = document.getElementById('map');

    const api_url = geoapi_url + this.fromTarget.value + url_append
    fetch(api_url).then(response => response.json())
      .then((data) => {
        const coordinates = {
          lng: data.features[0].geometry.coordinates[0],
          lat: data.features[0].geometry.coordinates[1]
        };
        mapElement.dataset.markerFrom = JSON.stringify(coordinates)
      })

  }

  addToMarker() {
    const destinationInput = document.querySelector('#mapbox-directions-destination-input input')
    destinationInput.value = this.fromTarget.value
    destinationInput.focus()
    const mapElement = document.getElementById('map');

    const api_url = geoapi_url + this.fromTarget.value + url_append
    fetch(api_url).then(response => response.json())
      .then((data) => {
        const coordinates = {
          lng: data.features[0].geometry.coordinates[0],
          lat: data.features[0].geometry.coordinates[1]
        };
        mapElement.dataset.markerTo = JSON.stringify(coordinates)
      })
  }
}
