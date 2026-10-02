terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

resource "docker_network" "murillomassa_web" {
  name = "murillomassa-web"
}

resource "docker_image" "nginx" {
  name = "nginx:alpine"
}

resource "docker_container" "web" {
  name  = "murillomassa-web"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8082
  }

  networks_advanced {
    name = docker_network.murillomassa_web.name
  }
}
