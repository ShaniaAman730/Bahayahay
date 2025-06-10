// app/javascript/controllers/index.js

import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

// You can add other stimulus controllers here
import HelloController from "./hello_controller"

const application = Application.start()
application.register("hello", HelloController)

export { application }
