import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-form"
export default class extends Controller {
  static targets = ["row", "form"]

  // connect() {
  //   console.log(this.formTargets)
  // }

  reveal() {
    this.formTargets.forEach(target => target.classList.toggle("d-none"))
    this.rowTargets.forEach(target => target.classList.toggle("d-none"))
  }
}
