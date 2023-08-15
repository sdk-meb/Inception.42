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

# ?? no detaching -> runs in the foreground
# runs in the background as a detached process / 
build:
	@mkdir -p --mode=766 /tmp/data/wordpress
	@mkdir -p --mode=766 /tmp/data/mariadb
	@docker build --tag=floor:latest srcs/requirements/tools
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
  		docker image prune ; \
    	docker network prune; \
    	docker volume prune; \
	}

down:
	@export services_path="$(PWD)/srcs/requirements"; \
	docker compose -f $(YAML) down --volumes
	@sudo rm -rf /tmp/data
	@printf "${NAME} down! \n"

re: clean all

.PHONY: all down re clean fclean build

fclean: clean
	@printf "Remove unused docker data ...\n"
	@docker system prune --all --volumes --force

