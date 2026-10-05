# Stash Group Scrapers

Community group scrapers for [Stash](https://github.com/stashapp/stash).

## Available Scrapers

- **Empire Stores**: `empirestores.co`
- **HotMovies**: `hotmovies.com`
- **Jeedoo**: `jeedoo.com`
- **AdultFilmIndex**: `adultfilmindex.com`
- **Adult DVD Marketplace**: `adultdvdmarketplace.com`
- **Excalibur Films**: `excaliburfilms.com`

The scrapers support group name searches, direct URL scraping, and fragment
scraping where supported by the source. Available metadata depends on the
source page.

## Install From the Scraper Index

1. Open **Settings -> Metadata Providers** in Stash.
2. Add this scraper source:

   ```text
   https://gcrosemond.github.io/Scrapers/index.yml
   ```

3. Reload the available metadata providers.
4. Install the scraper you want to use.

Some sources require an age-confirmation cookie. The scraper definitions set
the required cookie where it can be handled automatically.

## Local Development

The repository requires `zip` and Ruby, both available by default on macOS and
GitHub-hosted Ubuntu runners.

```sh
# Build ZIPs and a generated index under dist/
make build

# Build and verify generated SHA-256 checksums
make check

# Remove generated artifacts
make clean
```

Generated files are written to `dist/` and are intentionally ignored by Git.
The ZIP archives contain the scraper YAML and its `manifest` file.

## Releases

Releases are tag-driven. Push a version tag such as:

```sh
git tag v0.1.0
git push origin v0.1.0
```

The GitHub Actions workflow will:

- build each scraper ZIP;
- generate `dist/index.yml` with the release version and SHA-256 checksums;
- publish `index.yml` and the ZIPs to GitHub Pages; and
- attach the same artifacts to a GitHub Release.

The published scraper index is:

```text
https://gcrosemond.github.io/Scrapers/index.yml
```
