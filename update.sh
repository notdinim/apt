#!/usr/bin/env bash
set -euo pipefail
KEY="dinimonyige@gmail.com"

# index of every .deb in this folder
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# release file: checksums of the index
apt-ftparchive release . > Release

# sign it two ways (older and newer apt use different ones)
gpg --default-key "$KEY" -abs -o - Release > Release.gpg
gpg --default-key "$KEY" --clearsign -o - Release > InRelease

# public key for users to download
gpg --armor --export "$KEY" > KEY.gpg