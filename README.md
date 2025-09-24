# Lapis Rocky

This is a Docker image that you can use as a base to quickly set up and deploy
web applications that use the Lapis framework.

# Usage

## Environment Variables

* **LAPIS_ENV** - Default is `production`

## Pre-installed Rocks

* bcrypt
* busted
* i18n
* lapis
* lsqlite3
* luacov
* luasec
* mailgun
* markdown
* moonscript
* lua-cjson

## Deploy

```sh
docker run \
-dti \
-v "$CWD/data:/var/data" \
-v "$CWD/www:/var/www" \
-e LAPIS_ENV="development" \
-p 8080:80 \
--name lapis-test \
darltrash/lapis-rocky:latest
```

```sh
./dev.sh
```

```sh
./prod.sh
```

## Example Application

Please visit the GitHub repository to download an example application that is
pre-configured for this image. The application is in the `www` directory. Copy
the contents of this directory into your `www` volume.
