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

The app loads shared app cards from `apps.json`. Browser `localStorage` is used only for per-device overrides made through settings mode.

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
- Edit mode shows column controls for `3`, `4`, and `5` columns.
- Edit mode shows green add buttons in empty grid slots.
- App cards open their configured URL in the same browser tab.
- Existing cards can be edited or deleted while settings mode is on.
- Published/shared app cards are defined in `apps.json`.
- Settings changes made in the browser are stored as local overrides for that device.
- The settings panel can reset a device back to the published `apps.json` list.
- The grid and cards resize to fit the visible browser viewport without page scrolling.
- Cards are capped at one-third of the shorter screen dimension so they do not dominate the TV display.
- App cards support keyboard/remote navigation with arrow keys and Enter.
- In settings mode, cards are not selectable; remote focus moves through the column controls, reset, add, edit, and delete buttons.

## Updating Shared Apps

Edit `apps.json`, commit the change, and push to `main`.

GitHub Pages will publish the new app list automatically. Devices with no local overrides will pick up the published list on their next page load.

`apps.json` uses `columns` to choose the layout width:

```json
{
  "columns": 3,
  "apps": []
}
```

Supported column counts are `3`, `4`, and `5`. Rows are calculated automatically from the configured apps.

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

## Files

- `index.html` - complete application
- `CNAME` - custom domain for GitHub Pages
- `Dockerfile` - optional static nginx container
- `docker-compose.yml` - optional local container run
- `deploy/truenas-compose.yml` - TrueNAS deployment compose file
- `.github/workflows/publish-image.yml` - manual workflow for publishing the optional container image
- `docs/github-pages.md` - GitHub Pages and Porkbun DNS setup
- `docs/deployment.md` - LAN, DNS, TrueNAS, and CI/CD notes
- `.dockerignore` - keeps container context small
- `.gitignore` - excludes local/editor/generated files
- `ASSISTANT.md` - implementation notes for future assistant work
