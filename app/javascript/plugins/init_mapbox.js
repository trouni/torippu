import mapboxgl from 'mapbox-gl';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

const geoapi_url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
const url_append = '.json?access_token=pk.eyJ1Ijoib25pZ2lyaXB3IiwiYSI6ImNqdmoxN2ZnNTBidzI0MGszMWRqbzg4eWcifQ.Kq3ipy7NCPpLWqM49pyY_g'

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker[0], marker[1] ]));
  map.fitBounds(bounds, { padding: 200, maxZoom: 15 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const markers = [[139.77,35.68]];

  if (mapElement) {
    const fromCoordinates = JSON.parse(mapElement.dataset.markerFrom)
    const toCoordinates = JSON.parse(mapElement.dataset.markerTo)

    const originInput = document.getElementById('trip_start_point')
    const destinationInput = document.getElementById('trip_end_point')

    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;

    var map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [139.77,35.68],
        zoom: 5
    });

    // initialFitMapToMarkers(map, )

    var mapDirections = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        controls: {
            inputs: false
        },
        styles: [{
            'id': 'directions-route-line',
            'type': 'line',
            'source': 'directions',
            'layout': {
                'line-cap': 'round',
                'line-join': 'round'
            },
            'paint': {
                'line-color': '#8AB3F0',
                'line-width': 3
            },
            'filter': [
                'all',
                ['in', '$type', 'LineString'],
                ['in', 'route', 'selected']
            ]
        },{
            'id': 'directions-origin-point',
            'type': 'circle',
            'source': 'directions',
            'paint': {
                "circle-radius": 7,
                "circle-color": "#8AD7B4"
            },
            'filter': [
                'all',
                ['in', '$type', 'Point'],
                ['in', 'marker-symbol', 'A']
            ]
        },{
            'id': 'directions-destination-point',
            'type': 'circle',
            'source': 'directions',
            'paint': {
                "circle-radius": 7,
                "circle-color": "#E38FB6"
            },
            'filter': [
                'all',
                ['in', '$type', 'Point'],
                ['in', 'marker-symbol', 'B']
            ]
        }]
    })

    originInput.addEventListener("change", (event) => {
    const api_url = geoapi_url + event.currentTarget.value + url_append
    fetch(api_url).then(response => response.json())
      .then((data) => {
        const coordinates = [
          data.features[0].geometry.coordinates[0],
          data.features[0].geometry.coordinates[1]
        ];
        mapDirections.setOrigin(coordinates);
        markers[0] = coordinates;
        fitMapToMarkers(map, markers);
        map.addControl(mapDirections);
      })
    })

    destinationInput.addEventListener("change", (event) => {
    const api_url = geoapi_url + event.currentTarget.value + url_append
    fetch(api_url).then(response => response.json())
      .then((data) => {
        const coordinates = [
          data.features[0].geometry.coordinates[0],
          data.features[0].geometry.coordinates[1]
        ];
        mapDirections.setDestination(coordinates);
        if (markers.length < 2) {
          markers.push(coordinates)
        } else {
          markers[1] = coordinates;
        }
        fitMapToMarkers(map, markers);
        map.addControl(mapDirections);
      })
    })

      // map.on('load', function() {
      //     // ON LOAD, SET LAT and LNG

      //     // WORKS IF YOU UNCOMMENT THIS
      //     mapDirections.setOrigin(fromCoordinates)
      //     mapDirections.setDestination(toCoordinates)
      //     map.addControl(mapDirections, 'top-left');
      // })

  }
}

export { initMapbox }
