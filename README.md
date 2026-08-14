# Kousen CommandCenter

Kousen CommandCenter is a lightweight LAN homepage for launching home-hosted apps such as KousenTV, Plex, music, photos, and future services.

The first version is intentionally static and contained in `index.html`. It can be opened directly in a browser, served by GitHub Pages, served from a small web server, or copied into a web-serving container later.

## Local Testing

From this folder:

```sh
python3 -m http.server 8080
```

Then open:

```text
http://127.0.0.1:8080
```

The app stores its grid size and app cards in browser `localStorage`.

## Container Testing

Build and run the local nginx container:

```sh
docker compose up -d --build
```

Then open:

```text
http://127.0.0.1:8080
```

## Preferred Deployment

The preferred first deployment target is GitHub Pages:

```text
git push -> GitHub Pages -> https://kousen.cc
```

See `docs/github-pages.md` for the GitHub and Porkbun setup steps.

## Current Behavior

- The top-left title is `Kousen CommandCenter`.
- The top-right settings button toggles edit mode.
- Edit mode shows grid-size controls for `3x3`, `4x4`, and `5x5`.
- Edit mode shows green add buttons in empty grid slots.
- App cards open their configured URL in the same browser tab.
- Existing cards can be edited or deleted while settings mode is on.

## Optional LAN Deployment Strategy

If internet-independent hosting is needed later, the clean TrueNAS/LAN target is:

```text
kousen.cc -> 192.168.10.50
```

Where `192.168.10.50` is an additional static IP/alias on the TrueNAS host reserved for CommandCenter. The TrueNAS management UI should remain bound to its management address, for example:

```text
192.168.10.10 -> TrueNAS UI
192.168.10.50 -> Kousen CommandCenter
```

DNS can point `kousen.cc` at the CommandCenter IP, but DNS cannot include a port. For `http://kousen.cc` to work, CommandCenter must answer on port `80`.

See `docs/deployment.md` for the optional TrueNAS compose and GitHub Container Registry deployment flow.

## Shared Configuration Later

This MVP uses browser-local storage. That is good for quick local testing, but each device gets its own layout.

If one shared layout is needed across TVs, tablets, and computers, add a tiny backend later that reads and writes a JSON config file. The UI can stay mostly the same.

## Files

- `index.html` - complete application
- `CNAME` - custom domain for GitHub Pages
- `Dockerfile` - optional static nginx container
- `docker-compose.yml` - optional local container run
- `deploy/truenas-compose.yml` - TrueNAS deployment compose file
- `.github/workflows/publish-image.yml` - builds and publishes the container image on pushes to `main`
- `docs/github-pages.md` - GitHub Pages and Porkbun DNS setup
- `docs/deployment.md` - LAN, DNS, TrueNAS, and CI/CD notes
- `.dockerignore` - keeps container context small
- `.gitignore` - excludes local/editor/generated files
- `ASSISTANT.md` - implementation notes for future assistant work
