#* Makefile - v3 *#

YAML=srcs/docker-compose.yml
NAME=INC

# runs in the background as a detached process / 
DETACH=-d
DETACH=; # no detaching -> runs in the foreground

build:
	@printf "Building configuration ${NAME}...\n"
	@docker compose -f $(YAML) up --build ${DETACH}	

all:
	@printf " up ${NAME}...\n"
	@docker compose -f $(YAML) up  ${DETACH}

${NAME}: build

clean: down
	@printf "cleaning ... \n"
	@docker system prune --all --force

down:
	@docker compose -f $(YAML) down
	@printf "${NAME} down! \n"

run:
	@printf "nginx serves runing ...\n"
	@docker run  -it srcs-nginx

re: clean all

fclean: clean
	@printf "Remove unused docker data ...\n"
	@yes | docker system prune --all --volumes
	@docker network prune --force


.PHONY	: all down re clean fclean build run
