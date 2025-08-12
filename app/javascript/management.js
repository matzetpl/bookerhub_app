// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "datepicker"
import "jquery"; // this import first
import $ from "jquery";
window.$ = $;
window.jQuery = $;

import Rails from '@rails/ujs';
Rails.start();


import { Turbo } from "@hotwired/turbo-rails";
Turbo.session.drive = true; 
Turbo.config.forms.mod ="optin"
import "controllers"


import { showSuccess, showError } from "management_notifications";
window.showSuccess = showSuccess;
window.showError = showError;

import "fontawesome-free"
