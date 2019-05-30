import { Controller } from "stimulus"
import places from 'places.js';

export default class extends Controller {
  static targets = [ "inputAddress" ]

  connect() {
    const placesOptions = {
      language: 'en',
      countries: ['jp']
    }
    this.inputAddressTargets.forEach( (target) => {
      places({ container: this.inputAddressTarget }).configure(placesOptions)
    });
  }
}
