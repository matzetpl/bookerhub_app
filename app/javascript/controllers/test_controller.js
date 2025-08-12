// app/javascript/controllers/test_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Define a target for your HTML element
  static targets = ["content"];
  connect() {
    console.log("Resource Modal Controller Registered");
  }
  // Action that updates the target content
  updateContent() {

    this.contentTarget.innerHTML = "The content has been updated!";
  }

  // Action that shows an alert for testing purposes
  showAlert() {
    alert("This is a test alert from the controller!");
  }
}
