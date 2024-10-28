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

## Configure ACME Proxy Server

The following environment variables are available:

- `ACMEPROXY_SERVER_ENDPOINT` - The hostname of the ACME Proxy server. If not set, the container will use the hostname of the container.
- `ACMEPROXY_SERVER_USERNAME` - The default user for the ACME Proxy server. Default is `acmeproxy`.
- `ACMEPROXY_SERVER_PASSWORD` - The default password for the ACME Proxy server. Default is `acmeproxy`.

## Configure ACME Client used by ACME Proxy Server

The following environment variables are available:

- `ACME_EMAIL` - The email address for the ACME Proxy server.
- `ACME_SERVER` - The ACME issuer to use. Default is `letsencrypt`.
- `ACME_DNS_PROVIDER` - The DNS provider to use for the ACME challenge.

## Security Notes

The [madcamel/acmeproxy.pl](https://github.com/madcamel/acmeproxy.pl) was written to be run within an internal network. It's not recommended to expose your acmeproxy host to the outside world.

Use of this certificate scheme will expose your internal network's hostnames via the certificate signer's public certificate transparency logs. If you're not comfortable with that, it is recommended not to use this approach. Please note that this is not a failing in acmeproxy.pl, but rather a characteristic of how public certificate authorities operate.

## License

Licensed under the [MIT License](./LICENSE).
