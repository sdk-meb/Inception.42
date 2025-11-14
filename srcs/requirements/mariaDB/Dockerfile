#=======================================================================#
# Docker image made-up by debian as base and mariadb (mysql)
#     server:  { DATA-BASE }  required
#====================================================================#

# debian as floor base
FROM floor:latest

RUN apt install -y mariadb-server 

EXPOSE 3306

COPY ./conf/creat_db.sh /sbin/db.setup

CMD ["sh", "/sbin/db.setup"]
