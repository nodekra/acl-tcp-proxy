# ACL proxy (tcp)


#### ENV variables


| `Name`        | `default`      | `option`| `example`|
| ------------- |-------------:|-------------:|-------------:| 
|UPSTREAM_LIST | |required| 5432:postgres\|9200:elasticsearch|
|ALLOW_LIST| |option|192.168.1.1/32\|0.0.0.0/0|


Данные из переменных подставляются во время старта контейнера генерируя nginx.conf для `nginx`.

пример для открытия доступа к zookeeper и postgres извне докер сети для дефолтных сетей + 192.168.0.0/16 и 0.0.0.0/0 :

```yaml
  zookeeper:
    image: zookeeper

  postgres:
    image: postgis:9.6
    environment:
        POSTGRES_USERS: "user:password|api:apipassword"
        POSTGRES_DATABASES: "user:user|api:api"

  db-proxy:
    image: nodekra/acl-tcp-proxy:latest
    environment: 
        UPSTREAM_LIST: "5432:postgres|2181:zookeeper"
        ALLOW_LIST: "192.168.0.0/16|0.0.0.0/0"
    ports:
        - 5432:5432
        - 2181:2181

```