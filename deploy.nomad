job "tarpanpathak-go-dependency-check-main" {
  datacenters = ["us-west-2"]
  type = "service"

  # Run the job on the "service" cluster.
  constraint {
    attribute = "${meta.cluster}"
    operator  = "="
    value     = "service"
  }

  group "go-dependency-check" {
    count = 1
    network {
      port "http" {
        to = 8080
      }
    }

    service {
      name = "${NOMAD_JOB_NAME}"
      tags = ["urlprefix-${NOMAD_JOB_NAME}"]
      port = "http"
      check {
        name     = "alive"
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    task "go-dependency-check" {
      driver = "docker"
      config {
        image = "ghcr.io/tarpanpathak/go-dependency-check:main"
        auth {
            username = "docker_user"
            password = "docker_pass"
        }
        force_pull = true
        ports = ["http"]
      }
      resources {
        cpu    = 128  # MHz
        memory = 64 # MB
      }
    }
  }
}