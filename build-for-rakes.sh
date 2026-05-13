#!/bin/bash
set -e

if docker image inspect registry.trgdev.com/qa/rakes-base-docker-image/ubuntu24-04-python3-13-poetry2-1-3 >/dev/null 2>&1; then
    echo "registry.trgdev.com/qa/rakes-base-docker-image/ubuntu24-04-python3-13-poetry2-1-3 already exists, skipping build"
else
    (
        cd ~/Documents/sources/qa/rakes-base-docker-image/
        docker build --tag=registry.trgdev.com/qa/rakes-base-docker-image/ubuntu24-04-python3-13-poetry2-1-3 .
    )
fi

if docker image inspect rakes >/dev/null 2>&1; then
    echo "rakes image already exists locally, skipping build"
else
    (
        cd ~/Documents/sources/qa/rakes/
        docker build --tag=rakes .
    )
fi

(
    cd ~/Documents/sources/_private/ralphex/
    docker build --tag=ralphex-rakes --file Dockerfile-rakes .
)
