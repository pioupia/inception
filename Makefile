up:
	sudo docker-compose -f srcs/docker-compose.yml up --build

all: up

.PHONY: all up