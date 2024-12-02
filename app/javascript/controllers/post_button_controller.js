import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['postButton', 'textField']

  clear_fields() {
    const form = event.target;

    requestAnimationFrame(() => {
      this.textFieldTargets.forEach((input) => {
        input.value = "";  
      });
    });
  }
}

