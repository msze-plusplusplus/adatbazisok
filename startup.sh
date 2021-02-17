#!/bin/bash

source docker-entrypoint.sh

if [ "$(id -u)" = "0" ]; then
    mysql_note "Switching to dedicated user 'mysql'"
    exec gosu mysql "$BASH_SOURCE" "$@"
fi

mysql_note "Entrypoint script for MySQL Server ${MARIADB_VERSION} started."

mysql_check_config "mysqld"
# Load various environment variables
docker_setup_env "mysqld"
docker_create_db_directories

# If container is started as root user, restart as dedicated mysql user
if [ "$(id -u)" = "0" ]; then
    mysql_note "Switching to dedicated user 'mysql'"
    exec gosu mysql "$BASH_SOURCE" "mysqld"
fi

# there's no database, so it needs to be initialized
if [ -z "$DATABASE_ALREADY_EXISTS" ]; then
    docker_verify_minimum_env

    # check dir permissions to reduce likelihood of half-initialized database
    ls /docker-entrypoint-initdb.d/ > /dev/null

    docker_init_database_dir "mysqld"

    mysql_note "Starting temporary server"
    docker_temp_server_start "mysqld"
    mysql_note "Temporary server started."

    docker_setup_db
    docker_process_init_files /docker-entrypoint-initdb.d/*

    mysql_note "Stopping temporary server"
    docker_temp_server_stop
    mysql_note "Temporary server stopped"

    echo
    mysql_note "MySQL init process done. Ready for start up."
    echo
fi

docker_setup_env "mysqld"
docker_temp_server_start "mysqld"

docker_process_init_files /scripts/database.sql /scripts/data.sql

docker_temp_server_stop

exec "mysqld"