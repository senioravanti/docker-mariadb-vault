# Модификация официального образа mariadb для работы с HashiCorp Vault

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

clear ; docker run -d --name $CONTAINER_NAME \
    -v "$ROOT_TOKEN_FILE:/run/secrets/vault/root-token.txt" \
    --network "$VAULT_NETWORK" \
    'stradiavanti/mariadb-vault:0.1'
```