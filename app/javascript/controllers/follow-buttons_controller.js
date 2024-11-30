import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['button', "acceptButton", "rejectButton"]

  change_request_button() {
    event.preventDefault()
    event.target.closest('form').submit()
    
    this.buttonTarget.value = 'Follow Request Sent'
    this.buttonTarget.disabled = true
  }

  change_accept_button() {
    event.preventDefault()
    event.target.closest('form').submit()

    this.acceptButtonTarget.value = 'Request accepted'
    this.acceptButtonTarget.disabled = true
    this.rejectButtonTarget.style.display = "none"
  }

  change_reject_button() {
    event.preventDefault()
    event.target.closest('form').submit()

    this.rejectButtonTarget.value = 'Request deleted'
    this.rejectButtonTarget.disabled = true
    this.acceptButtonTarget.style.display = "none"
  }
}
