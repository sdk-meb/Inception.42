#* Makefile - v3 *#
include srcs/.env

export db_name
export services_path=$(PWD)/srcs/requirements
export LAB_NAME=inception

# -----
%:
	@docker compose -f $(YAML) $*


# -----
.PHONY: ${NAME} all re clean fclean destroy


# -----
${NAME}: all

all: create_data_path
	@docker build --tag=floor:latest ${services_path}/tools
	@docker compose  --env-file srcs/.env -f $(YAML) up --build --detach


# -----
clean: sudo/clean_data
	@docker compose -f $(YAML) down --volumes

re: clean all

fclean: clean


destroy/%:
	@docker system prune --volumes --force \
		--filter "label=lab=inception"


# -----
create_data_path:
	@mkdir -p ${HOME}/data
	@mkdir -p --mode=766 ${HOME}/data/wordpress
	@mkdir -p --mode=766 ${HOME}/data/mariadb

sudo/clean_data:
	sudo -k rm -rf ${HOME}/data



clean/1:
	docker compose -f $(YAML) down

# Level 2: Bring down services
clean/2: sudo/clean_data
	docker compose -f $(YAML) down --volume

# Level 3: Remove stopped services
clean/3:
	docker compose -f $(YAML) rm -vsa

# Level 4: Prune unused elements
clean/4:
	docker system prune -a --volumes --filter "label=lab=$(LAB_NAME)"

# Level 5: Remove all images with a specific label
clean/5:
	docker rmi $(docker images -q --filter "label=lab=$(LAB_NAME)")