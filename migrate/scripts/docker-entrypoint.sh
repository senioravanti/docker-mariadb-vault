set -u

ROOT_TOKEN=$(cat /run/secrets/vault/root-token.txt)
DATABASE_PASSWORD=$(curl -sS -H "Authorization: Bearer $ROOT_TOKEN" -X GET 'http://vault:8200/v1/cubbyhole/mariadb/password' | jq -c -r '.data.data.value')

exec migrate \
    -path=/migrations \
    -database="$DATABASE_DRIVER://$DATABASE_USER:$DATABASE_PASSWORD@tcp($DATABASE_HOST:$DATABASE_PORT)/$DATABASE_NAME" \
    "$@"