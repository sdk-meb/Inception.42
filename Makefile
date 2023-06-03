#* Makefile - v3 *#

YAML=srcs/docker-compose.yml

all:
	docker-compose -f $(YAML) up

clean:
	docker-compose -f $(YAML) down
	sh config.sh clear

re:

