# GitHub Pages Deployment

GitHub Pages is the preferred first deployment target for Kousen.CommandCenter.

The app is a static `index.html`, so GitHub Pages can serve it directly from the repository root. No build step is required. Shared defaults are loaded from `apps.json`, and static images are served from `assets/`.

Shared app cards are defined in `apps.json`. Updating that file and pushing to `main` updates the published CommandCenter app list. The `columns` value controls whether the app grid uses 2, 3, or 4 columns; rows are calculated automatically.
The default browser icon is `assets/logo.png`, and the default homepage background is `assets/bliss.png`.

## Cost

GitHub Pages is available for public repositories on GitHub Free. This project can use GitHub Pages without an extra hosting fee as long as the repository remains public.

## Repository Settings

In the GitHub repo:

1. Open **Settings**.
2. Open **Pages**.
3. Under **Build and deployment**, set **Source** to **Deploy from a branch**.
4. Set:

```text
Branch: main
Folder: / root
```

5. Save.
6. Under **Custom domain**, enter:

```text
kousen.cc
```

7. Save.
8. After GitHub provisions the certificate, enable **Enforce HTTPS**.

This repo includes a root-level `CNAME` file containing `kousen.cc`. GitHub requires the filename to be uppercase and the file to contain only one domain.

## Porkbun DNS

For the apex domain, add GitHub Pages `A` records:

```text
Type  Host  Answer
A     @     185.199.108.153
A     @     185.199.109.153
A     @     185.199.110.153
A     @     185.199.111.153
```

For `www`, add:

```text
Type   Host  Answer
CNAME  www   npkousen.github.io
```

Remove any conflicting `A`, `CNAME`, forwarding, or parking records for `@` and `www`.

DNS changes can take time to propagate. GitHub may also take time to issue the HTTPS certificate after DNS is correct.

## Runtime Model

The public page loads from:

```text
https://kousen.cc
```

Cards can still navigate directly to LAN apps:

```text
KousenTV -> http://192.168.10.10:8000
Plex     -> http://192.168.10.10:32400/web
```

The internet is only used to load CommandCenter and any internet-backed widgets. Media playback from LAN apps remains local after the user navigates to those LAN URLs.

## Shared App Updates

To update the app cards for every device:

1. Edit `apps.json`.
2. Commit the change.
3. Push to `main`.
4. Wait for GitHub Pages to deploy.

Devices that have local settings overrides will keep those overrides until someone opens settings and clicks **Reset to Defaults**.
