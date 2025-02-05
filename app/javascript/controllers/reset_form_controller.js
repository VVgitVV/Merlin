/*import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="reset-form"
export default class extends Controller {
  reset() {
    this.element.reset();
  }
}

*/
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reset-form"
export default class extends Controller {
  submitOnEnter(event) {
    if (event.key === "Enter") {
      event.preventDefault();
      this.element.requestSubmit(); // Submit the form programmatically
    }
  }

  reset() {
    this.element.reset();
  }
}
