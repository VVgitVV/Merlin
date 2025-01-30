import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stopwatch"
export default class extends Controller {
  static targets = ["stopwatchButton", "buttonText"]

  changeText(event) {
    // event.preventDefault()
    if (this.stopwatchButtonTarget.children[0][1].value == 'Start'){
      this.stopwatchButtonTarget.children[0][1].value = 'The clock is ticking!'
    } else {
      this.stopwatchButtonTarget.children[0][1].value = 'Start'
    }
  }
}
