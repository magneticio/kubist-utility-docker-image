#!/usr/bin/env bash

set -e

VERSION=$1

docker build -t magneticio/kubist-utility:$VERSION
docker push magneticio/kubist-utility:$VERSION

docker tag magneticio/kubist-utility:$VERSION magneticio/kubist-utility:Latest
docker push magneticio/kubist-utility:latest
