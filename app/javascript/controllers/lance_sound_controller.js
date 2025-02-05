import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["audio"];

  connect() {
    console.log("LanceSoundController connected");
    // this.audioTarget.currentTime = 0; // Reset the audio to the beginning
    // this.audioTarget.play();
    var audio = new Audio('assets/zapsplat_impacts_wood_plank_snap_break_101480.mp3');
    audio.play();
  }


  play() {

  }
}
