target "acmeproxy" {
    context = "https://github.com/madcamel/acmeproxy.pl.git"
    dockerfile = "Dockerfile"
}

target "default" {
    tags = [
        "acmeproxy:dev"
    ]
}
