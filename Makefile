# Makefile - v3
include $(dir $(firstword $(MAKEFILE_LIST)))srcs/.env

project_path=$(dir $(firstword $(MAKEFILE_LIST)))
requirements=$(project_path)srcs/requirements
export LAB_NAME db_name services_path


# -----
${NAME}: all


all: create_data_path floor



re: clean all

fclean: clean/3


# ----- mounted volume path managment
.PHONY: create_data_path sudo/clean_data
create_data_path:
	mkdir -p ${HOME}/data
	@mkdir -p --mode=766 ${HOME}/data/wordpress
	@mkdir -p --mode=766 ${HOME}/data/mariadb

sudo/clean_data:
	sudo -k rm -rf ${HOME}/data

# Build the Docker image for the floor
.PHONY: floor

floor:
	docker build --tag=floor:latest ${requirements}/tools

# Run the Docker Compose
all: create_data_path floor
	docker compose --env-file $(project_path)srcs/.env -f $(project_path)$(YAML) up --build --detach

# ----- Clean Levels
.PHONY: clean clean/2 clean/3 clean/4 clean/5
clean: compose/down

clean/2: sudo/clean_data 
	docker compose -f $(project_path)$(YAML) down --volumes

clean/3: clean/2
	docker system prune -f --volumes --filter "label=lab=$(LAB_NAME)"

clean/4: clean/2
	docker image rm $(shell docker images -q --filter "label=lab=$(LAB_NAME)")

clean/5: clean/2
	docker system prune -a -f --volumes --filter "label=lab=$(LAB_NAME)"

# # -----
compose/%:
	docker compose -f $(project_path)$(YAML) $*

