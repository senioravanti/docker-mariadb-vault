FROM migrate/migrate:v4.18.2

VOLUME [ "/run/secrets/vault/", "/migrations" ]

RUN apk add --no-cache --update \
    curl \
    jq

ENV DATABASE_NAME=test_db
ENV DATABASE_USER=senioravanti

ENV DATABASE_DRIVER=mysql

ENV DATABASE_HOST=mariadb
ENV DATABASE_PORT=3306

COPY ./scripts/* /usr/local/bin/init-migrate/
RUN chmod +x /usr/local/bin/init-migrate/*.sh

ENTRYPOINT [ "/bin/sh", "/usr/local/bin/init-migrate/docker-entrypoint.sh" ]
CMD [ "up" ]