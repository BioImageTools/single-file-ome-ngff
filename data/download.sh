#!/bin/bash
# Downloads the sample file and creates a root and no root sample.
set -euxo pipefail
url="https://zenodo.org/records/13305156/files/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr.zip?download=1"
wget -O test.with_root.zip "$url"

# unzip to tmp folder
mkdir tmp
unzip -d tmp test.with_root.zip
cd tmp/*.zarr

# create a zip without root folder
zip -r ../../test.without_root.zip *

# remove the tmp folder
rm -rf tmp
