#!/usr/bin/env bash

set -e

VERSION=$1

docker build -t magneticio/kubist-util:$VERSION .
docker push magneticio/kubist-util:$VERSION

docker tag magneticio/kubist-util:$VERSION magneticio/kubist-util:Latest
docker push magneticio/kubist-util:latest
