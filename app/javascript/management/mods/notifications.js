import toastr from "toastr";

toastr.options = {
  closeButton: true,
  progressBar: true,
  positionClass: "toast-top-center",
  timeOut: "3000"
};


export function showSuccess(message, title = "") {
  toastr.success(message, title);
}

export function showError(message, title = "") {
  toastr.error(message, title);
}

export function showInfo(message, title = "") {
  toastr.info(message, title);
}

export function showWarning(message, title = "") {
  toastr.warning(message, title);
}