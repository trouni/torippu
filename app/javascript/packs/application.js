import "bootstrap";
import "controllers";
import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

import { initAutocomplete } from "plugins/init_autocomplete";
import { initMapbox } from "plugins/init_mapbox";

initAutocomplete();
initMapbox();

// const geoapi_url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/'
// const url_append = '.json?access_token=pk.eyJ1Ijoib25pZ2lyaXB3IiwiYSI6ImNqdmoxN2ZnNTBidzI0MGszMWRqbzg4eWcifQ.Kq3ipy7NCPpLWqM49pyY_g'
