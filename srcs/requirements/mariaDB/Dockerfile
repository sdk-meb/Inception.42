#=======================================================================#
# Docker image made-up by debian as base and mariadb (mysql)
#     server:  { DATA-BASE }  required
#====================================================================#

# deb-OS as base 
FROM debian:buster

# base floor
RUN	apt update &&\
    apt upgrade

RUN apt install mariadb-server mariadb-client -y

EXPOSE 3306

COPY ./conf/creat_db.sh /tmp/creat_db.sh

ENTRYPOINT ["sh", "/tmp/creat_db.sh"]

CMD ["mysqld"]