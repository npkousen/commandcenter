# Kousen.CommandCenter

Kousen.CommandCenter is a lightweight homepage for launching home-hosted apps and simple live widgets from TVs, tablets, kiosk PCs, and normal browsers.

Version: `0.2.0`

The app is intentionally static-first. The primary experience lives in `index.html`, shared defaults live in `apps.json`, and visual assets live in `assets/`.

## Deployment Model

The preferred deployment target is GitHub Pages:

```text
git push -> GitHub Pages -> https://kousen.cc
```

GitHub Pages serves the homepage publicly. App cards can point to private LAN URLs such as:

```text
KousenTV -> http://192.168.10.10:8000
Plex     -> http://192.168.10.10:32400/web
```

Those LAN cards only work from devices connected to the home network. This is expected.

## Local Testing

From this folder:

```sh
python3 -m http.server 8080
```

Then open:

```text
http://127.0.0.1:8080
```

## Container Testing

The container path is optional. GitHub Pages is the simpler deployment for now.

```sh
docker compose up -d --build
```

Then open:

```text
http://127.0.0.1:8080
```

## Configuration

Shared defaults are loaded from `apps.json`. Devices with local settings overrides keep those overrides until **Reset to Defaults** is selected in settings mode.

Example:

```json
{
  "columns": 3,
  "homepageName": "Kousen",
  "accentColor": "#5ba37d",
  "backgroundColor": "#1e3a8a",
  "backgroundImage": "assets/bliss.png",
  "backgroundTransparency": 0,
  "apps": []
}
```

Supported homepage values:

- `columns`: `2`, `3`, or `4`
- `homepageName`: title prefix before `.CommandCenter`
- `accentColor`: color for the homepage name and active controls
- `backgroundColor`: base gradient color and translucent top bar color
- `backgroundImage`: optional image path or local data URL
- `backgroundTransparency`: app card transparency level, using `0`, `25`, or `50`

Supported app card types:

- `link`: opens a configured URL in the same browser tab
- `weather`: uses a ZIP code and refresh cadence to render a live weather tile
- `clock`: uses a timezone and digital or analog display style

## Current UX

- The title renders as accent-colored `Kousen` plus white `.CommandCenter`.
- `assets/command-center-icon-final.png` is the full-resolution app icon source, with browser/mobile sizes exported alongside it.
- `assets/bliss.png` is the default background image.
- The default background color is Blue.
- App cards resize to fit the viewport without page scrolling.
- Cards are capped at one-third of the shorter viewport dimension.
- Settings mode supports add, edit, delete, reorder, undo, redo, import, export, homepage editing, and layout changes.
- Keyboard and remote navigation use arrow keys and Enter.
- Escape, remote back/home, or clicking outside a control clears the current highlight.
- In settings mode, app cards are not selectable; their controls are selectable instead.

## Assets

```text
assets/
  apple-touch-icon.png  Apple touch icon
  bliss.png             default homepage background
  command-center-icon-final.png  full-resolution app icon source
  favicon-32.png        browser favicon
  logo-192.png          192px browser/mobile icon
  logo.png              512px app icon
```

`bliss.png` is intentionally referenced as a file instead of embedded in `index.html`. It is large enough that embedding it as base64 would make the page and local settings harder to manage.
Keep raw source images, such as `assets/bliss_raw.png`, out of published builds unless they are intentionally needed at runtime.
Draft icon explorations live in `assets/drafts/`, which is ignored by git.

## Files

- `index.html` - complete static application
- `apps.json` - shared published defaults
- `assets/` - image assets used by the static app
- `CNAME` - GitHub Pages custom domain
- `Dockerfile` - optional static nginx container
- `docker-compose.yml` - optional local container run
- `deploy/truenas-compose.yml` - optional TrueNAS deployment compose file
- `.github/workflows/publish-image.yml` - manual container publish workflow
- `docs/github-pages.md` - GitHub Pages and Porkbun DNS notes
- `docs/deployment.md` - optional LAN/TrueNAS deployment notes
- `LICENSE` - CommandCenter project license
- `THIRD_PARTY_NOTICES.md` - Lucide/Feather icon attribution
- `ASSISTANT.md` - project notes for future assistant work

## Licensing

CommandCenter is licensed under the MIT License. See `LICENSE`.

Inline SVG icons are from Lucide. Lucide is licensed under the ISC License, and some Lucide icons are derived from Feather icons under the MIT License. See `THIRD_PARTY_NOTICES.md`.

## Release Notes

### 0.2.0

- Added favicon/app icon support from `assets/logo.png`.
- Moved visual assets into `assets/`.
- Changed the default background color to Blue.
- Kept `assets/bliss.png` as the default background image.
- Added project license and third-party icon notices.
- Refreshed docs for the current deployment and UX model.
