# Optional TrueNAS Deployment Strategy

This project can deploy as a tiny static nginx container if a LAN-hosted or internet-independent version is needed later. The image serves `index.html`, `apps.json`, and the `assets/` directory.

The preferred first deployment target is GitHub Pages. See `docs/github-pages.md`.

## Target Topology

```text
kousen.cc -> 192.168.10.50 -> CommandCenter container on port 80
```

TrueNAS management remains separate:

```text
192.168.10.10 -> TrueNAS UI
192.168.10.50 -> Kousen.CommandCenter
```

## One-Time TrueNAS Network Setup

1. In TrueNAS, add `192.168.10.50/24` as an alias/static IP on the active network interface.
2. Bind the TrueNAS Web UI to only the management IP, for example `192.168.10.10`.
3. Reserve `192.168.10.50` outside the router DHCP pool, or create a DHCP reservation if your network design requires it.
4. Confirm `http://192.168.10.50` does not show the TrueNAS login page before deploying CommandCenter.

## One-Time Porkbun DNS Setup

Create these DNS records:

```text
A  kousen.cc      192.168.10.50
A  www.kousen.cc  192.168.10.50
```

This intentionally points public DNS at a private LAN address. Devices outside the LAN will fail to load it, which is acceptable for this intranet-style design.

## Image-Based CI/CD

The easiest Git-driven deployment path is:

1. Push changes to `main`.
2. GitHub Actions builds the Docker image.
3. GitHub Actions publishes it to GitHub Container Registry.
4. TrueNAS runs that published image.
5. TrueNAS pulls the new image when updated.

The workflow is in `.github/workflows/publish-image.yml`. It is manual-only because GitHub Pages is the primary deployment path.

The deployment compose file is already pointed at this repo's expected GHCR image:

```yaml
image: ghcr.io/npkousen/commandcenter:latest
```

If the GitHub repo is private, TrueNAS needs credentials to pull from GHCR. A public repo/package avoids that extra step.

## TrueNAS Compose Deployment

Use `deploy/truenas-compose.yml` as the production compose definition:

```yaml
services:
  commandcenter:
    image: ghcr.io/npkousen/commandcenter:latest
    container_name: kousen-commandcenter
    ports:
      - "192.168.10.50:80:80"
    restart: unless-stopped
```

The important line is:

```text
192.168.10.50:80:80
```

That binds the container to the CommandCenter alias IP on standard HTTP port `80`.

## Update Options

Manual update:

```sh
docker compose -f deploy/truenas-compose.yml pull
docker compose -f deploy/truenas-compose.yml up -d
```

More automated update:

- Use TrueNAS app update behavior if it is available for the custom app.
- Or run an image updater such as Watchtower on the NAS.

Manual update is the safer first step. Add automation after the basic LAN endpoint is reliable.

## Kiosk PC

Do kiosk setup after `http://kousen.cc` works from another LAN device.

The kiosk PC should not need special DNS configuration. It only needs normal LAN network access and a Chromium autostart command pointed at:

```text
http://kousen.cc
```
