# Build Golang plugins

FROM golang:1.20-bullseye AS plugin-builder

WORKDIR /builder

COPY ./hello ./go_plugins/hello

RUN find ./go_plugins -maxdepth 1 -mindepth 1 -type d -not -path "*/.git*" | \
    while read dir; do \
        cd $dir && go build -o /builds/$dir main.go  ; \
    done

# Build Kong
FROM kong:2.8.3-ubuntu

USER root

RUN apt-get update

RUN apt-get install -y build-essential libssl-dev

RUN luarocks install openssl

RUN luarocks install luaossl OPENSSL_DIR=/usr/local/kong CRYPTO_DIR=/usr/local/kong

COPY --from=plugin-builder ./builds/go_plugins/  ./kong/

USER kong
