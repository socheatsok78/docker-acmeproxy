variable "ACMEPROXY_VERSION" { default = "9d6b5c0a8471ba37dc91da0cebbfc4b3d6081c9e" }
variable "ALPINE_VERSION" { default = "latest" }
variable "S6_OVERLAY_VERSION" { default = "v3.2.0.2-minimal" }

target "docker-metadata-action" {}
target "github-metadata-action" {}

target "default" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
}

target "dev" {
    inherits = [
        "docker-metadata-action",
        "github-metadata-action",
    ]
    args = {
        ALPINE_VERSION = "${ALPINE_VERSION}"
        S6_OVERLAY_VERSION = "${S6_OVERLAY_VERSION}"
    }
    tags = [
        "socheatsok78/acmeproxy:dev"
    ]
}
