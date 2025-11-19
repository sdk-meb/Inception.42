#* Makefile - v3 *#
include $(dir $(firstword $(MAKEFILE_LIST)))srcs/.env

export db_name
project_path=$(dir $(firstword $(MAKEFILE_LIST)))
requirements=$(project_path)srcs/requirements
export services_path=./requirements
export LAB_NAME=inception

# # -----
%:
	@docker compose -f $(project_path)$(YAML) $*


# -----
.PHONY: ${NAME} all re fclean 


# -----
${NAME}: all

floor:
	@docker build --tag=floor:latest ${requirements}/tools

all: create_data_path floor
	@docker compose  --env-file $(project_path)srcs/.env -f $(project_path)$(YAML) up --build --detach



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
	docker compose -f $(project_path)$(YAML) down --volumes

clean/3: clean/2
	docker system prune -f --volumes --filter "label=lab=$(LAB_NAME)"

clean/4: clean/2
	docker image rm $(shell docker images -q --filter "label=lab=$(LAB_NAME)")

clean/5: clean/2
	docker system prune -a -f --volumes --filter "label=lab=$(LAB_NAME)"
