COMPOSE		=	docker-compose -f srcs/docker-compose.yml

all: up

clean:
	docker stop $$(docker ps -qa)
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	docker network rm $$(docker network ls -q) 2>/dev/null


fclean: clean
	rm -rf /home/pioupia/data/wordpress/*
	rm -rf /home/pioupia/data/mariadb/*
	rm -rf /home/pioupia/data/redis/*

re: fclean build

build:
	$(COMPOSE) up --build

down:
	$(COMPOSE) down

up:
	$(COMPOSE) up

.PHONY: all clean fclean re build down up
