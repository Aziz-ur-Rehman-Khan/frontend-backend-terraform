locals {

  frontend_env_content = file(var.env_files["frontend-${var.environment}"])
  frontend_environment_variables = {
    for line in split("\n", local.frontend_env_content) :
    split("=", line)[0] => split("=", line)[1]
  }

  backend_env_content = file(var.env_files["backend-${var.environment}"])
  backend_environment_variables = {
    for line in split("\n", local.backend_env_content) :
    split("=", line)[0] => split("=", line)[1]
  }

}

