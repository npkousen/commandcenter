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

- The top-left title is `Kousen.CommandCenter`.
- The top-right settings button toggles edit mode.
- Edit mode shows column controls for `2`, `3`, and `4` columns.
- Edit mode shows undo and redo controls for changes made during the current browser session.
- Edit mode can export the current setup to JSON and import that setup later or on another device.
- Edit mode includes an Edit Homepage control for the CommandCenter name, accent color, background color, background image, and image dim level.
- Edit mode shows green add buttons in empty grid slots.
- Link app cards open their configured URL in the same browser tab.
- Weather and clock app cards render as live homepage widgets.
- Existing cards can be edited or deleted while settings mode is on, with delete confirmation.
- Existing cards can be reordered left or right while settings mode is on.
- App cards can use initials or a custom uploaded logo.
- Weather widgets use a ZIP code and refresh cadence. Clock widgets use a timezone and digital or analog display mode.
- Published/shared app cards are defined in `apps.json`.
- Settings changes made in the browser are stored as local overrides for that device.
- The settings panel can reset a device back to the published `apps.json` list.
- The grid and cards resize to fit the visible browser viewport without page scrolling.
- Cards are capped at one-third of the shorter screen dimension so they do not dominate the TV display.
- App cards support keyboard/remote navigation with arrow keys and Enter.
- In settings mode, cards are not selectable; remote focus moves through the column controls, reset, add, edit, delete, reorder, and modal controls.

## Updating Shared Apps

Edit `apps.json`, commit the change, and push to `main`.

GitHub Pages will publish the new app list automatically. Devices with no local overrides will pick up the published list on their next page load.

`apps.json` uses `columns` to choose the layout width and can define the shared homepage defaults:

```json
{
  "columns": 3,
  "homepageName": "Kousen",
  "accentColor": "#5ba37d",
  "backgroundColor": "#111827",
  "backgroundImage": "bliss.png",
  "backgroundTransparency": 0,
  "apps": []
}
```

Supported column counts are `2`, `3`, and `4`. Rows are calculated automatically from the configured apps.
`backgroundTransparency` controls app card transparency and supports `0`, `25`, and `50`.

CommandCenter displays a small version label at the bottom of the page. Increment the patch version by `0.0.1` for normal updates and the minor version by `0.1.0` for larger releases.

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
