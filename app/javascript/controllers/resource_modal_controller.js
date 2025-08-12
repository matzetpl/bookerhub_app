import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect() {

    const turbotarget = document
    this.modal = document.getElementById("resourceModal");
    this.modalContent = document.getElementById("resourceModalContent");

    this.modalCloseButton = document.getElementById("resourceModalClose");

    // Bind the click event to the close method
    if (this.modalCloseButton) {
      this.modalCloseButton.addEventListener("click", this.close.bind(this));
    }
    // Bind the event listener for turbo:frame-load
    turbotarget.addEventListener("turbo:before-stream-render", this.onTurboFrameLoad.bind(this));
 

  }

  open(event) {

    // Show the modal by removing the 'hidden' class and adding 'flex'
    this.modal.classList.remove("hidden");
    this.modal.classList.add("flex");

    // Add the outside click listener
    document.addEventListener("click", this.closeOnClickOutside);
  }

  close(event) {
    console.log("Closing modal");

    // Hide the modal by adding 'hidden' class and removing 'flex'
    this.modal.classList.add("hidden");
    this.modal.classList.remove("flex");

    // Remove the outside click listener
    document.removeEventListener("click", this.closeOnClickOutside);
  }

  onTurboFrameLoad(event) {
    const turboFrame = event.target;
  
    // Check if the event corresponds to the modal content frame
    if (turboFrame.target === "resourceModalContent") {
      const template = turboFrame.querySelector("template");
  
      // Check if the template exists
      if (template) {
        // Find the turbo-frame inside the template
        const turboFrameInsideTemplate = template.content.querySelector("turbo-frame");
  
        if (turboFrameInsideTemplate && turboFrameInsideTemplate.innerHTML.trim() === "") {
          // If the turbo-frame inside template is empty, close the modal
          this.close();
        } else {
          // If the turbo-frame inside template has content, open the modal
          this.open();
        }
      }
    }
  }
  
}


