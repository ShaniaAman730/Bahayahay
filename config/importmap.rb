# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@rails/ujs", to: "@rails--ujs.js", preload: true
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "hello_importmap", to: "controllers/hello_importmap.js"
pin_all_from "app/javascript/controllers", under: "controllers"

