#=======================================================================#
# Docker image made-up by debian as base and mariadb (mysql)
#     server:  { DATA-BASE }  required
#====================================================================#

# debian as floor base
FROM floor:latest

COPY ./conf/creat_db.sh /tmp/creat_db.sh
RUN apt install -y mariadb-server mariadb-client &&\
	chmod +x /tmp/creat_db.sh


EXPOSE 3306


ENTRYPOINT ["sh", "/tmp/creat_db.sh"]

CMD ["mysqld"]