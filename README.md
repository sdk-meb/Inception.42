# Inception
### system administration

#### + key points
    - docker
    - docker compose
    - volumes
    - networking
    - SSL/TLS
    - nginx
    - wordpress
    - mariadb


<strong>__ virtualize several Docker images __<strong>

#### Goal:
    set_up of a small infrastructure composed of different services

#### Diagram (plantuml)
```plantuml

classDiagram
    class Nginx {
        +start()
        +stop()
    }

    class WordPress {
        +createPost()
        +editPost()
        +deletePost()
    }

    class MariaDB {
        +connect()
        +readData()
        +writeData()
    }

    Nginx --> WordPress : Tunnel Proxy
    WordPress --> MariaDB : Read/Write Data
```


#### meanings:
    -  SSL/TLS
        Secure Sockets Layer - Transport Layer Security
         ( TLS and SSL are for the same roles, TLS is an updated service but SSL is deprecated )
            is for Etablishing Encrybtion conection layer/tube between hosts { server/clients }


#### resources:

+ https://www.docker.com/ 
+ NGINIX https://www.plesk.com/blog/various/nginx-configuration-guide
+ https://developer.wordpress.org/advanced-administration/before-install/multiple-instances/
+ https://mariadb.com/docs