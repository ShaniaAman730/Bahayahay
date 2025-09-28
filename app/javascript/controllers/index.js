// app/javascript/controllers/index.js
import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Dynamically import all controllers
const controllerFiles = import.meta.glob("./**/*_controller.js", { eager: true })

for (const path in controllerFiles) {
  const controller = controllerFiles[path]
  const identifier = path
    .split("/")
    .pop()
    .replace(/_controller\.js$/, "")
    .replace(/_/g, "-")

  application.register(identifier, controller.default)
}


