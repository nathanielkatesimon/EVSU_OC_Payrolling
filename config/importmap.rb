# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "coreui", to: "https://cdn.jsdelivr.net/npm/@coreui/coreui@5.0.1/dist/js/coreui.bundle.min.js"
pin "jquery.repeater", to: "form_repeater.js" # @1.2.1
pin "jquery", to: "https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js" # @3.7.1
