#* Makefile - v3 *#
include srcs/.env

export db_name
export services_path=$(PWD)/srcs/requirements
export LAB_NAME=inception

# -----
%:
	@docker compose -f $(YAML) $*


# -----
.PHONY: ${NAME} all re fclean 


# -----
${NAME}: all

all: create_data_path
	@docker build --tag=floor:latest ${services_path}/tools
	@docker compose  --env-file srcs/.env -f $(YAML) up --build --detach



re: clean all

fclean: clean/3


# ----- mounted volume path managment
.PHONY: create_data_path sudo/clean_data
create_data_path:
	@mkdir -p ${HOME}/data
	@mkdir -p --mode=766 ${HOME}/data/wordpress
	@mkdir -p --mode=766 ${HOME}/data/mariadb

sudo/clean_data:
	sudo -k rm -rf ${HOME}/data


# ----- Clean Levels
.PHONY: clean clean/2 clean/3 clean/4 clean/5
clean: down

clean/2: sudo/clean_data 
	docker compose -f $(YAML) down --volumes

clean/3: clean/2
	docker system prune -f --volumes --filter "label=lab=$(LAB_NAME)"

clean/4: clean/2
	docker image rm $(shell docker images -q --filter "label=lab=$(LAB_NAME)")

clean/5: clean/2
	docker system prune -a -f --volumes --filter "label=lab=$(LAB_NAME)"
