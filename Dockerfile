FROM postgres:16-alpine@sha256:0cefaabd882e42bcb2a2f3dc56d3ce4770560ba62fd7f197f1a2e008fd5731ab
LABEL org.opencontainers.image.source="https://github.com/robinchoice/postgres-pgbackrest"
RUN apk add --no-cache pgbackrest \
    && mkdir -p /etc/pgbackrest \
    && chown postgres:postgres /etc/pgbackrest
COPY --chmod=644 pgbackrest.conf /etc/pgbackrest/pgbackrest.conf
