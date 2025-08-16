export function eagerLoadControllersFrom(glob, application) {
  const controllerFiles = import.meta.glob(`${glob}/**/*_controller.js`, { eager: true })

  for (const path in controllerFiles) {
    const controller = controllerFiles[path]
    const identifier = path
      .split("/")
      .pop()
      .replace(/_controller\.js$/, "")
      .replace(/_/g, "-")

    application.register(identifier, controller.default)
  }
}
