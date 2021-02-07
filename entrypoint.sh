#!/usr/bin/env sh
set -e
     
### set DEBUG
[ "$DEBUG" = "true" ] && set -x

### PORT MAPPING/BINDING
UPSTREAM_ARR=$(echo "$UPSTREAM_LIST" | tr "|" "\n")
for UPSTREAM in $UPSTREAM_ARR
do
    UPSTREAM_PORT=$(echo "$UPSTREAM" | cut -d: -f1)
    UPSTREAM_NAME=$(echo "$UPSTREAM" | cut -d: -f2)
    PORT_MAPPING="$PORT_MAPPING\t\t$UPSTREAM_PORT $UPSTREAM_NAME;\n"
    PORT_BINDING="$PORT_BINDING\t\tlisten $UPSTREAM_PORT;\n"
done

### SET ACL
NET_ARR=$(echo "$ALLOW_LIST" | tr "|" "\n")
for NET in $NET_ARR
do
    NET=$(echo "$NET" |sed 's@\/@\\/@g')
    NET_LIST="$NET_LIST\t\tallow $NET;\n"
done


sed -i "s/_upstream_list_/$PORT_MAPPING/g" /etc/nginx/nginx.conf
sed -i "s/_listen_/$PORT_BINDING/g" /etc/nginx/nginx.conf
sed -i "s/_allow_/$NET_LIST/g" /etc/nginx/nginx.conf

exec "$@"
