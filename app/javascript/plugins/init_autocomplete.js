import places from 'places.js';

const initAutocomplete = () => {
  let addressInput = document.getElementById('trip_start_point');
  if (addressInput) {
    places({ container: addressInput,
      language: 'en',
      countries: ['jp'] });
  }
  addressInput = document.getElementById('trip_end_point');
  if (addressInput) {
    places({
      container: addressInput,
      language: 'en',
      countries: ['jp'] });
  }
};

export { initAutocomplete };
