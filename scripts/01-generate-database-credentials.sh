set -u

MARIADB_NEW_ROOT_PASSWORD=$(pwgen -1cns 24)
MARIADB_NEW_PASSWORD=$(pwgen -1cns 8)

printf "*** start generate secure random passwords\n"
mariadb --user=root --password="$MARIADB_ROOT_PASSWORD" \
    -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$MARIADB_NEW_ROOT_PASSWORD');"

mariadb --user=root --password="$MARIADB_NEW_ROOT_PASSWORD" \
    -e "SET PASSWORD FOR '$MARIADB_USER' = PASSWORD('$MARIADB_NEW_PASSWORD');"
printf "*** end generate passwords\n"

ROOT_TOKEN=$(cat /run/secrets/vault/root-token.txt)
printf "*** upload new passwords to the vault\n"
clear ; curl -sS -i \
    -H "Authorization: Bearer $ROOT_TOKEN" \
    -X POST \
    --json "{\"data\":{\"value\":\"$MARIADB_NEW_ROOT_PASSWORD\"}}" \
    http://vault:8200/v1/cubbyhole/mariadb/root-password
echo "$?"

clear ; curl -sS -i \
    -H "Authorization: Bearer $ROOT_TOKEN" \
    -X POST \
    --json "{\"data\":{\"value\":\"$MARIADB_NEW_PASSWORD\"}}" \
    http://vault:8200/v1/cubbyhole/mariadb/password
printf "*** end upload\n"
echo "$?"