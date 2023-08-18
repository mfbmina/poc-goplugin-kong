# Build Golang plugins

FROM golang:1.20 AS plugin-builder

WORKDIR /builder

COPY ./hello ./go_plugins/hello

RUN find ./go_plugins -maxdepth 1 -mindepth 1 -type d -not -path "*/.git*" | \
    while read dir; do \
        cd $dir && go build -o /builds/$dir main.go  ; \
    done

# Build Kong
FROM kong:3.4.0-ubuntu

COPY --from=plugin-builder ./builds/go_plugins/  ./kong/

USER kong
