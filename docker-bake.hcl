variable "ALPINE_VERSION" { default = "latest" }
variable "S6_OVERLAY_VERSION" { default = "v3.2.0.2" }
variable "ACMEPROXY_VERSION" { default = "a7e5a62e79b2ddc8aa110d08934f6ed4b14a30c7" }

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
        ACMEPROXY_VERSION = "${ACMEPROXY_VERSION}"
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
        ACMEPROXY_VERSION = "${ACMEPROXY_VERSION}"
    }
    tags = [
        "socheatsok78/acmeproxy:dev"
    ]
}
