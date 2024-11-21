#!/bin/bash

# Tested on Ubuntu 22.04
# install:
# sudo apt install gdal-bin

gdalmdiminfo --version
## GDAL 3.4.1, released 2021/12/27

gdalmdiminfo ../data/20200812-CardiomyocyteDifferentiation14-Cycle1.zarr
# works

gdalmdiminfo ../data/test.with_root.zip 
## ERROR 4: `../data/test.with_root.zip' not recognized as a supported file format.
## gdalmdiminfo failed - unable to open '../data/test.with_root.zip'.

gdalmdiminfo ../data/test.without_root.zip 
## ERROR 4: `../data/test.without_root.zip' not recognized as a supported file format.
## gdalmdiminfo failed - unable to open '../data/test.without_root.zip'.



# with docker pull ghcr.io/osgeo/gdal:ubuntu-small-3.10.0:
sudo docker run -it  -v "$(pwd)"/data:/data ghcr.io/osgeo/gdal:ubuntu-small-3.10.0

# in container
gdalmdiminfo --version                
## GDAL 3.10.0, released 2024/11/01

gdalmdiminfo /data/test.with_root.zip
## ERROR 4: `/data/test.with_root.zip' not recognized as being in a supported file format.
## gdalmdiminfo failed - unable to open '/data/test.with_root.zip'.


gdalmdiminfo /data/test.without_root.zip
## ERROR 4: `/data/test.without_root.zip' not recognized as being in a supported file format.
## gdalmdiminfo failed - unable to open '/data/test.without_root.zip'.
