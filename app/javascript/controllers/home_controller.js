import { Controller } from "stimulus"
import Typed from 'typed.js';

export default class extends Controller {
  connect() {
    new Typed('#home-search-input', {
      strings: ["Tokyo", "Osaka", "Kyoto", "Fukuoka", "Yokohama"],
      typeSpeed: 40,
      backSpeed: 20,
      startDelay: 100,
      attr: 'placeholder',
      loop: true
    });
  }
}
