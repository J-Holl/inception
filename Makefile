PATH_YML = ./srcs/docker-compose.yml
PATH_WORDPRESS = /home/jholl/data/wordpress
PATH_MARIADB = /home/jholl/data/mariadb

#associate localhost with jholl.42.fr
#create dir for volumes + give them rights
#docker compose | -f specifiy the file .yml | up create and start containers |
# -d run containers in background | --build build images before starting them
all:
	@cat /etc/hosts | if ! grep -P "127.0.0.1\tjholl.42.fr"; then sudo sh -c 'echo "127.0.0.1\tjholl.42.fr" >> /etc/hosts'; fi
	@sudo mkdir -p $(PATH_MARIADB)
	@sudo mkdir -p $(PATH_WORDPRESS)
	@sudo chmod 777 $(PATH_MARIADB)
	@sudo chmod 777 $(PATH_WORDPRESS)
	@sleep 1
	@sudo docker compose -p 42 -f $(PATH_YML) up -d --build



re: clean all

#stop services
stop:
	@sudo docker compose -p 42 -f $(PATH_YML) stop

#stop and remove containers, networks
clean: stop
	@sudo docker compose -p 42 -f $(PATH_YML) down -v

#remove directory for volume
#remove all unused containers, networks, images | -a all not just dangling |
# -f no prompt for confirmation
fclean: clean
	@sudo docker system prune -af
	@sudo rm -rf $(PATH_WORDPRESS)
	@sudo rm -rf $(PATH_MARIADB)
