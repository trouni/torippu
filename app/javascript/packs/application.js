import "bootstrap";
import "controllers";
import 'mapbox-gl/dist/mapbox-gl.css';
import mapboxgl from 'mapbox-gl';
// import MapboxDirections from '@mapbox/mapbox-gl-directions';

import { initAutocomplete } from "plugins/init_autocomplete";
import { initMapbox } from "plugins/init_mapbox";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

initAutocomplete();
initMapbox();