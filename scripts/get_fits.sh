#!/bin/bash
# e.g. ./get_fits.sh $PWD 1.4.0

base_dir=$1
version=$2

if [ ! -d "$base_dir" ]; then
  echo "\$1 must be a directory"
  exit 1
fi

if [ -z "$version" ]; then
  echo "\$2 must be a version"
  exit 1
fi

wget "https://github.com/harvard-lts/fits/releases/download/$version/fits-$version" -O "$base_dir/fits-$version.zip"
cd $base_dir
unzip fits-$version.zip -d fits-$version
