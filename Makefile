build:
	docker-compose -f srcs/docker-compose.yml up --build

up:
	docker-compose -f srcs/docker-compose.yml up

all: up

.PHONY: all up build