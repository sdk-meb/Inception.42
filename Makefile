#* Makefile - v3 *#
include srcs/.env

export YAML
export NAME
export DETACH

build:
	@docker build --tag=floor srcs/requirements/tools
	@mkdir -p /tmp/data/wordpress
	@mkdir -p /tmp/data/mariadb
	@printf "Building configuration ${NAME}...\n"
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) up --build ${DETACH}


up:
	@printf " up ${NAME}...\n"
	@docker compose -f $(YAML) up

${NAME}: build

clean: down
	@printf "cleaning ... \n"
	@yes | { \
		\
		docker container prune; \
  		docker image prune --all; \
    	docker network prune; \
    	docker volume prune; \
	}

down:
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) down
	@printf "${NAME} down! \n"

re: clean all

fclean: clean
	@printf "Remove unused docker data ...\n"
	@docker system prune --all --volumes --force
	@sudo rm -rf /tmp/dataa



.PHONY: all down re clean fclean build
