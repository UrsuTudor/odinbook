import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['button']

  change_request_button() {
    event.preventDefault()
    event.target.closest('form').submit()
    
    this.buttonTarget.value = 'Follow Request Sent'
    this.buttonTarget.disabled = true
  }

  change_accept_button() {
    event.preventDefault()
    event.target.closest('form').submit()

    this.buttonTarget.value = 'Request accepted'
    this.buttonTarget.disabled = true
  }

  change_reject_button() {
    event.preventDefault()
    event.target.closest('form').submit()

    this.buttonTarget.value = 'Request deleted'
    this.buttonTarget.disabled = true
  }
}
