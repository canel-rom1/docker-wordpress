DBFILE      ?= ./wp-database.sql
DBNAME      ?= wordpress 
DBCONTAINER ?= wp-db

WPCONTAINER ?= wp
WPFILES     ?= ./wp-directory.tgz

config:
	cp docker-compose.override.yml-example docker-compose.override.yml
	cp env-example .env

adminer:
	docker run -d --rm --network=wordpress_lan -p 8080:8080 adminer:latest

db_export:
	@docker exec -it $(DBCONTAINER) sh -c "mariadb-dump -u root -p $(DBNAME) > /tmp/db.sql"
	@docker cp $(DBCONTAINER):/tmp/db.sql $(DBFILE)
	@docker exec $(DBCONTAINER) rm -f /tmp/db.sql

db_import:
	@docker cp $(DBFILE) $(DBCONTAINER):/tmp/db.sql
	@docker exec -it $(DBCONTAINER) sh -c "mariadb -u root -p $(DBNAME) < /tmp/db.sql ; rm -f /tmp/db.sql"	

wp_export:
	@docker exec -it $(WPCONTAINER) sh -c "cd /var/www/html && tar -zpcvf /tmp/dir.tgz ."
	@docker cp $(WPCONTAINER):/tmp/dir.tgz $(WPFILES)
	@docker exec $(WPCONTAINER) rm -f /tmp/dir.tgz

wp_import:
	@docker cp $(WPFILE) $(WPCONTAINER):/tmp/dir.tgz
	@docker exec -it $(WPCONTAINER) sh -c "cd /var/www/html && rm -fr * && tar -zpxvf /tmp/dir.tgz"
