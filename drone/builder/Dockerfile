FROM {{ golang_image }}

# Install build dependencies.
RUN apk add --no-cache \
    make \
    gcc \
    g++

COPY ./builder-entrypoint.sh /
ENTRYPOINT [ "/builder-entrypoint.sh" ]
