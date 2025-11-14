#* Makefile - v3 *#
include srcs/.env

export YAML
export NAME
export USER
export db_name
export services_path=$(PWD)/srcs/requirements


# -----
%:
	@docker compose -f $(YAML) $*


# -----
.PHONY: ${NAME} all re clean fclean build destroy up


# -----
${NAME}: all

all: build

build: creat_data
	@docker build --tag=floor:latest srcs/requirements/tools
	@printf "Building configuration ${NAME}...\n"
	@docker compose  --env-file srcs/.env -f $(YAML) up --build --detach

up:
	@docker compose --env-file srcs/.env -f $(YAML) up --detach


# -----
clean: sudo/clean_data
	@docker compose -f $(YAML) down --volumes

re: clean all

# fclean: clean

destroy: fclean
	@docker system prune --volumes --force \
		--filter "label=lab=inception"


# -----
creat_data:
	@mkdir -p ${HOME}/data
	@mkdir -p --mode=766 ${HOME}/data/wordpress
	@mkdir -p --mode=766 ${HOME}/data/mariadb

sudo/clean_data:
	sudo -k rm -rf ${HOME}/data

