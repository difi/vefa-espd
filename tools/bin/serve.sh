#!/bin/sh

FOLDER=$(dirname $(readlink -f "$0"))/../..

dc () {
    if [ $(command -v docker-compose | wc -l) = "1" ]; then
        docker-compose \
            --project-directory $FOLDER \
            -f $FOLDER/docker-compose.yml \
            -p vefa-ehf-espd \
            run --rm $@
    else
        docker run --rm -i \
            -v /var/run/docker.sock:/var/run/docker.sock \
            -v $FOLDER:/src \
            docker/compose:1.18.0 \
            --project-directory $FOLDER -f /src/docker-compose.yml -p vefa-ehf-espd run --rm $@
    fi
}

dc --service-ports serve