import "bootstrap";

import "controllers";

import { initAutocomplete } from "plugins/init_autocomplete";

import 'mapbox-gl/dist/mapbox-gl.css';

import { initMapbox } from '../plugins/init_mapbox';

initAutocomplete();

initMapbox();
