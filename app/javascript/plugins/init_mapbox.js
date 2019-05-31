import mapboxgl from 'mapbox-gl';

const geoapi_url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
const url_append = '.json?access_token=pk.eyJ1Ijoib25pZ2lyaXB3IiwiYSI6ImNqdmoxN2ZnNTBidzI0MGszMWRqbzg4eWcifQ.Kq3ipy7NCPpLWqM49pyY_g'
// const boarder = [
// [128.522924, 31.350410], // Southwest coordinates
// [146.349173, 43.461032]  // Northeast coordinates
// ];
const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker[0], marker[1] ]));
  map.fitBounds(bounds, { padding: 300, maxZoom: 10 });
};

const initMapbox = () => {
  const mapCreateTrip = document.getElementById('map-create-trip');
  const mapSearch = document.getElementById('map-search');
  const markers = [[139.77,35.68]];

  if (mapCreateTrip) {
    const fromCoordinates = JSON.parse(mapCreateTrip.dataset.markerFrom)
    const toCoordinates = JSON.parse(mapCreateTrip.dataset.markerTo)

    const originInput = document.getElementById('trip_start_point')
    const destinationInput = document.getElementById('trip_end_point')

    mapboxgl.accessToken = mapCreateTrip.dataset.mapboxApiKey;

    var map = new mapboxgl.Map({
        container: 'map-create-trip',
        style: 'mapbox://styles/mapbox/streets-v9',
        center: [139.77,35.68],
        zoom: 5,
        // maxBounds: boarder
    });
    map.addControl(new mapboxgl.NavigationControl());
    // map.scrollZoom.disable();

    // initialFitMapToMarkers(map, )

    var mapDirections = new MapboxDirections({
        accessToken: mapboxgl.accessToken,
        system: 'metric',
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
                'line-color': '#488286',
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
                "circle-color": "#488286"
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
                "circle-color": "#488286"
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
        new mapboxgl.Marker(map)
          .setLngLat(coordinates)
          .addTo(map);
        fitMapToMarkers(map, markers);

        if (markers.length === 2) {
          map.addControl(mapDirections, 'top-left');
        }
        // document.getElementById('trip-duration-info').innerHTML = document.querySelector('.mapbox-directions-component.mapbox-directions-route-summary').innerHTML
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
        if (markers.length < 2) {
          markers.push(coordinates)
        } else {
          markers[1] = coordinates;
        }
        mapDirections.setDestination(coordinates);
        if (markers.length === 2) {
          map.addControl(mapDirections, 'top-left');
        } else {
          fitMapToMarkers(map, markers);
        }
        new mapboxgl.Marker(map)
          .setLngLat(coordinates)
          .addTo(map);
        // document.getElementById('trip-duration-info').innerHTML = document.querySelector('.mapbox-directions-component.mapbox-directions-route-summary').innerHTML
      })
    })
  }

  if (mapSearch) {
    const originInput = document.getElementById('from')
    const destinationInput = document.getElementById('to')

    mapboxgl.accessToken = mapSearch.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map-search',
      bounds: boarder,
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapSearch.dataset.markers);
    const markersArray = []
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
      markersArray.push([ marker.lng, marker.lat ])
    });

    fitMapToMarkers(map, markersArray);
  }
}

export { initMapbox }
