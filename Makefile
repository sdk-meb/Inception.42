#* Makefile - v3 *#
include srcs/.env

export YAML
export NAME

CMD=$(cmd)

${CMD}:
	@printf " $(CMD) ${NAME}...\n"
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) $(CMD)

${NAME}: build

build:
	@docker build --tag=floor srcs/requirements/tools
	@printf "Building configuration ${NAME}...\n"
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) up --build 
#--detach

all: build

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
	docker compose -f $(YAML) down --volumes
	@sudo rm -rf /tmp/data
	@printf "${NAME} down! \n"
	@mkdir -p /tmp/data/wordpress
	@mkdir -p /tmp/data/mariadb

re: clean all

.PHONY: all down re clean fclean build

fclean: clean
	@printf "Remove unused docker data ...\n"
	@docker system prune --all --volumes --force

