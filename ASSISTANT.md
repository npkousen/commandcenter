# Assistant Notes

## Project Intent

Keep Kousen.CommandCenter lightweight. The app should remain static-first and easy to host from TrueNAS, nginx, Caddy, or a small Docker container.

The user explicitly prefers a straightforward implementation concentrated in a single `index.html` instead of a framework-heavy app.

## Network Assumptions

- TrueNAS SCALE is the expected always-on host.
- The NAS management IP is currently `192.168.10.10`.
- The intended CommandCenter pattern is to add a separate TrueNAS interface alias, such as `192.168.10.50`, and bind the CommandCenter web server to that address on port `80`.
- Public DNS may point `kousen.cc` at a private LAN IP, matching the earlier `kousen.tv` approach.
- DNS cannot map a hostname to a port. Clean URLs require a service listening on `80` or `443`.

## Implementation Guardrails

- Avoid adding build tooling unless the feature set clearly needs it.
- Prefer one static `index.html`.
- Keep shared app definitions in `apps.json`.
- Do not hardcode too many personal services beyond useful starter defaults.
- Browser `localStorage` is acceptable only for per-device overrides. Published defaults should come from `apps.json`.
- Maintain TV/tablet usability: large targets, stable grid cells, strong focus states, and short labels.
- Preserve kiosk behavior: no document scrolling in fullscreen, card size capped to one-third of the shorter viewport side, arrow-key/remote navigation, and Enter-to-open app cards.
- In settings mode, do not make app cards remote-focusable; expose add/edit/delete/reorder and layout controls instead.
- Supported layout widths are 2, 3, and 4 columns. Rows are automatic.
- The visible footer version is currently `0.2.1`. Increment by `0.0.1` for routine updates and by `0.1.0` for larger releases.
- Homepage name, accent color, background color, background image, app transparency level, and app logos are stored in the same shared/local state model as app cards. Uploaded images are stored as browser data URLs, so keep them small enough for localStorage.
- `assets/bliss.png` is the default published background image and should stay referenced as an asset rather than embedded in `index.html`.
- Raw source images such as `assets/bliss_raw.png` should not be shipped in published builds unless intentionally needed at runtime.
- `assets/logo.png` is the browser favicon/app icon.
- The default background color is Blue (`#1e3a8a`), the default accent color is Green (`#5ba37d`), the default app transparency level is `0`, and the default layout is 3 columns.
- Settings mode supports exporting/importing the current local setup as JSON; imported files must pass the same `validateState` path used for `apps.json`.
- App records can be `link`, `weather`, or `clock`. Weather widgets use Open-Meteo geocoding/forecast APIs with no API key; clock widgets render locally with `Intl.DateTimeFormat`.
