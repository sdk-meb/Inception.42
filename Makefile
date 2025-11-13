#* Makefile - v3 *#
include srcs/.env

export YAML
export NAME
export USER
export services_path=$(PWD)/srcs/requirements


${compose}:
	@echo -n "exec: " 
	docker compose -f $(YAML) $(compose)

.PHONY: all down re clean fclean build destroy up

up:
	docker compose --env-file srcs/.env -f $(YAML) up --detach

${NAME}: build

build: creat_data
	@docker build --tag=floor:latest srcs/requirements/tools
	@printf "Building configuration ${NAME}...\n"
	docker compose  --env-file srcs/.env -f $(YAML) up --build --detach

all: build


down:
	docker compose -f $(YAML) down

clean: sudo/clean_data
	@docker compose -f $(YAML) down --volumes


re: clean all


fclean: clean
	@docker compose rm mariadb nginx wordpress --stop --volumes 


destroy: fclean
	@docker system prune --volumes --all --force \
		--filter "label=lab=inception"

creat_data:
	@mkdir -p ${HOME}/data
	@mkdir -p --mode=766 ${HOME}/data/wordpress
	@mkdir -p --mode=766 ${HOME}/data/mariadb

sudo/clean_data:
	sudo -k rm -rf ${HOME}/data

