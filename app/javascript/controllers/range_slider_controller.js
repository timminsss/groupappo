import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range-slider"
export default class extends Controller {
  static targets = ['slider', 'label']

  connect() {
    this.labelTarget.innerHTML = `Average speed planned: ${this.sliderTarget.value} km / hour`
  }

  change() {
    console.log(this.sliderTarget.value)
    this.labelTarget.innerHTML = `Average speed planned: ${this.sliderTarget.value} km / hour`
  }
}
