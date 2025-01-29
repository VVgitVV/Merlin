import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stopwatch"
export default class extends Controller {
  static targets = ["stopwatchButton", "buttonText"]
  // connect() {
  //   console.log("Hello from stopwatch controller")
  // }

  changeText(event) {
    event.preventDefault()
    if (this.stopwatchButtonTarget.children[0][1].value == 'Start'){
      this.stopwatchButtonTarget.children[0][1].value = 'Stop'
    } else {
      this.stopwatchButtonTarget.children[0][1].value = 'Start'
    }
  }
}
