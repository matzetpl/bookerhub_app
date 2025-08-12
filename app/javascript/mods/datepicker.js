import Pikaday from "pikaday";

function initializeDatepickers() {
  console.log('initialize datepicker')
  document.querySelectorAll('.datepicker').forEach(input => {

    new Pikaday({
      field: input,
      format: 'YYYY-MM-DD',
    });

  });
}

// todo rewrite 
document.addEventListener('turbo:stream-load', initializeDatepickers);
document.addEventListener('turbo:frame-render', initializeDatepickers);
document.addEventListener('turbo:load', initializeDatepickers)
document.addEventListener('DOMContentLoaded', initializeDatepickers);  

window.initializeDatepickers = initializeDatepickers;