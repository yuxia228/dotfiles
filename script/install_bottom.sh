#!/bin/bash

API_URL="https://api.github.com/repos/ClementTsang/bottom/releases"

LATEST_VERSION=$( curl ${API_URL} | jq '.[].name' | grep Release | head -1 | cut -d' ' -f1 | sed 's/"//' )

DOWNLOAD_LINK=https://github.com/ClementTsang/bottom/releases/download/${LATEST_VERSION}/bottom_$(uname -m)-unknown-linux-gnu.tar.gz

mkdir -p ${HOME}/bin
cd ${HOME}/bin
mkdir ./tmp_btm && cd ./tmp_bmt
wget ${DOWNLOAD_LINK}
tar xf *.tar.*
cp -f btm ../

# Cleanup
cd ${HOME}/bin
rm -rf ./tmp_btm

