# Build Golang plugins

FROM kong/go-plugin-tool:2.0.4-alpine-latest AS plugin-builder

WORKDIR /builder

COPY ./hello ./go_plugins/hello

RUN find ./go_plugins -maxdepth 1 -mindepth 1 -type d -not -path "*/.git*" | \
    while read dir; do \
        cd $dir && go build -o /builds/$dir main.go  ; \
    done

ENTRYPOINT [ "ash" ]

# Build Kong
FROM kong:3.4.0-ubuntu

COPY ./config.yml  ./kong/

COPY --from=plugin-builder ./builds/go_plugins/  ./kong/

USER kong
