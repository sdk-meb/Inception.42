#* Makefile - v3 *#
include srcs/.env

export YAML
export NAME
export DETACH


build:
	@mkdir -p /tmp/dataa/wordpress
	@mkdir -p /tmp/dataa/mariadb
	@printf "Building configuration ${NAME}...\n"
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) up --build ${DETACH}

up:
	@printf " up ${NAME}...\n"
	@docker compose -f $(YAML) up

${NAME}: build

clean: down
	@printf "cleaning ... \n"
	@docker system prune

down:
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) down
	@printf "${NAME} down! \n"

re: clean all

fclean: clean
	@printf "Remove unused docker data ...\n"
	@yes | docker system prune --all --volumes
	@docker network prune --force
	@sudo rm -rf /tmp/dataa



.PHONY: all down re clean fclean build
