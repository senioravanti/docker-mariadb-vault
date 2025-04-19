# Расширение официального образа mariadb для работы с HashiCorp Vault

[Базовый образ](https://hub.docker.com/_/mariadb)

## Сборка и развертывание

```sh
clear ; docker build . \
    --no-cache \
    -f ./Dockerfile \
    -t 'stradiavanti/mariadb-vault:0.1' \
    --push
```

`VAULT_NETWORK` :: Название сети docker, в которой работает контейнер HashiCorp Valut
`ROOT_TOKEN_FILE` :: Путь к файлу с root-token vault на хосте. 

```sh
CONTAINER_NAME='my-mariadb-vault'
VAULT_NETWORK='my-vault-net'

ROOT_TOKEN_FILE='./vault/secrets/root-token.txt'

MARIADB_DATABASE='test_db'
MARIADB_USER='senioravanti'

clear ; docker run -d --name $CONTAINER_NAME \
    -v "$ROOT_TOKEN_FILE:/run/secrets/vault/root-token.txt" \
    -e "MARIADB_USER=$MARIADB_USER" \
    -e "MARIADB_DATABASE=$MARIADB_DATABASE" \
    --network "$VAULT_NETWORK" \
    'stradiavanti/mariadb-vault:0.1'
```