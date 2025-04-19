FROM mariadb:lts-noble

RUN mkdir -p /run/secrets/vault
VOLUME [ "/run/secrets/vault" ]

RUN apt update \
    && apt install -y \
        curl \
        pwgen

COPY ./config/my.cnf /etc/mysql/conf.d/my.cnf

COPY ./scripts/* /docker-entrypoint-initdb.d
RUN chmod +x /docker-entrypoint-initdb.d/*.sh