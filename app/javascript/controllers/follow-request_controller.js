import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['button']

  disable_button() {
    console.log("BUTTON CLICKED")
    this.buttonTarget.value = 'Follow Request Sent'
    this.buttonTarget.disabled = true
  }

}
