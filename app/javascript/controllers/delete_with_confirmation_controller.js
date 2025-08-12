// app/javascript/controllers/delete_with_confirmation_controller.js
import { Controller } from "stimulus";
import Swal from "sweetalert2";

export default class extends Controller {
  static targets = ["button"];

  connect() {
    console.log("DeleteWithConfirmation controller connected.");
  }

  delete(event) {
    event.preventDefault(); // Prevent default form submission or link follow

    // Show SweetAlert confirmation dialog
    Swal.fire({
      title: 'Are you sure?',
      text: "This action cannot be undone!",
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes, delete it!'
    }).then((result) => {
      if (result.isConfirmed) {
        // If confirmed, submit the form or trigger the link
        this.submitForm(event);
      }
    });
  }

  submitForm(event) {
    // If the button is part of a form, submit it using Turbo
    const form = this.element.closest("form");
    if (form) {
      // Submit the form with Turbo, no full page reload
      form.requestSubmit();
    }
  }
}
