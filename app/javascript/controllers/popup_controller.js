/*import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["popup", "button"];

  connect() {
    this.hidePopup(); // Ensure the popup starts hidden
  }

  showPopup() {
    this.popupTarget.classList.remove("hidden");
  }

  hidePopup() {
    this.popupTarget.classList.add("hidden");
  }
}*/

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["popup"];

  connect() {
    this.hidePopup();
  }

  showPopup() {
    this.popupTarget.classList.remove("hidden");
  }

  hidePopup() {
    this.popupTarget.classList.add("hidden");
  }
}
