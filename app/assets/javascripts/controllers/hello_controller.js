// app/javascript/controllers/hello_controller.js

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["output"]

  connect() {
    this.outputTarget.textContent = "Hello, Stimulus!"
  }
}
