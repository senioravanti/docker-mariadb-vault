# Расширение официального образа migrate

[Базовый образ](https://hub.docker.com/r/migrate/migrate)

## Сборка и развертывание

```sh
clear ; docker build . \
    --no-cache \
    -t 'stradiavanti/migrate-vault:0.1'
```

```sh
CONTAINER_NAME='my-migrate'
VAULT_NETWORK='my-vault-net'
DATABASE_NETWORK='my-dbms-net'
ROOT_TOKEN_FILE='./vault/secrets/root-token.txt'

clear ; docker run -d --name $CONTAINER_NAME \
    -v "$VAULT_ROOT_TOKEN_FILE:/run/secrets/vault/root-token.txt" \
    --network "$VAULT_NETWORK" \
    --network "$DATABASE_NETWORK" \
    'stradiavanti/migrate-vault:0.1'
```