#=======================================================================#
# Docker image made-up by debian as base and mariadb (mysql)
#     server:  { DATA-BASE }  required
#====================================================================#

# debian as floor base
FROM floor:latest

RUN apt install -y mariadb-server mariadb-client

EXPOSE 3306

COPY ./conf/creat_db.sh /tmp/db.sh

CMD ["sh", "/tmp/db.sh"]
