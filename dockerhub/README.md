# About
ACME DNS challenge proxy container of [madcamel/acmeproxy.pl](https://github.com/madcamel/acmeproxy.pl).

[Source] | [Docker Hub] | [GitHub Container Registry]

## Image

| Registry                    | Image                          |
| --------------------------- | ------------------------------ |
| [Docker Hub]                | socheatsok78/acmeproxy         |
| [GitHub Container Registry] | ghcr.io/socheatsok78/acmeproxy |


[Source]: https://github.com/socheatsok78/docker-acmeproxy
[Docker Hub]: https://hub.docker.com/r/socheatsok78/acmeproxy
[GitHub Container Registry]: https://github.com/socheatsok78/docker-acmeproxy/pkgs/container/acmeproxy

Following platforms for this image are available:

```bash
$ docker run --rm mplatform/mquery socheatsok78/acmeproxy:latest

# Image: socheatsok78/acmeproxy:latest
#  * Manifest List: Yes (Image type: application/vnd.oci.image.index.v1+json)
#  * Supported platforms:
#    - linux/amd64
#    - linux/arm64
```

## Releases

The release versioning scheme is based on **Alpine** releases, and it will follow the same versioning as the base image. The build matrix is generated using [`actions-matrix/alpine-matrix-action`](https://github.com/marketplace/actions/alpine-matrix-action) action.

Currently, the following versions are available:
- `latest`
- `edge`
- `3.20`
- `3.19`

> [!IMPORTANT]
> The release is automated on a weekly basis, and if there is a new version of the base image, the release will build and push the new version following the base image version.

## Usage

Here a simple example of how to use this image:

```yaml
services:
  acmeproxy:
    image: socheatsok78/acmeproxy:3.20
    environment:
      ACME_SERVER: letsencrypt_test
      ACME_DNS_PROVIDER: dns_cf
      CF_Zone_ID: abcdefghijklmnopqrstuvwxyz
      CF_Token: TOKEN-abcdefghijklmnopqrstuvwxyz
    hostname: acmeproxy.fqdn.domain
    volumes:
      - acmeproxy-data:/data:rw
      - acmeproxy-cache:/home/acmeproxy/.acme.sh:rw # optional
volumes:
  acmeproxy-data:
  acmeproxy-cache: # optional
```

## Environment Variables

The following environment variables are available:

- `ACMEPROXY_ENDPOINT` - The hostname of the ACME Proxy server. If not set, the container will use the hostname of the container.
- `ACMEPROXY_USERNAME` - The default user for the ACME Proxy server. Default is `acmeproxy`.
- `ACMEPROXY_PASSWORD` - The default password for the ACME Proxy server. Default is `acmeproxy`.
- `ACME_EMAIL` - The email address for the ACME Proxy server.
- `ACME_ISSUER` - The ACME issuer to use. Default is `letsencrypt`.
- `ACME_DNS_PROVIDER` - The DNS provider to use for the ACME challenge.

## License

Licensed under the [MIT License](https://github.com/socheatsok78/docker-acmeproxy/raw/main/LICENSE).
