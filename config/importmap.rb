# Pin npm packages by running ./bin/importmap


pin "application"
pin "jquery", to: "https://code.jquery.com/jquery-3.6.0.min.js"
pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.0.1/lib/assets/compiled/rails-ujs.js"
pin_all_from "app/javascript/controllers", under: "controllers"

pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true

pin "stimulus", to: "https://cdn.skypack.dev/stimulus"
pin "fontawesome-free", to: "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"

pin "management", to: "management.js"  # For backend/management pages
pin "sweetalert2" # @11.15.3
pin "toastr" # @2.1.4
pin "jquery" # @3.7.1
pin "management_notifications", to: "management/mods/notifications.js"
pin "pikaday" # @1.8.2
pin "moment" # @2.30.1
pin "datepicker", to: "mods/datepicker.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
