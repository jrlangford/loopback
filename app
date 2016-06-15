#!/bin/bash
APP_CONT_NAME="node"
MYSQL_CONT_NAME="mysql"
MYSQL_DUMMY_PASS="mysql"

function start-mysql {
	docker run -d \
		--name $MYSQL_CONT_NAME \
		-e MYSQL_ROOT_PASSWORD=$MYSQL_DUMMY_PASS \
		mysql:5.7 && \
	echo "Sleeping 22s while mysql starts" && \
	sleep 22 && \
	docker exec $MYSQL_CONT_NAME mysql -p$MYSQL_DUMMY_PASS -e "create database mydb;"
}

function stop-mysql {
	docker stop $MYSQL_CONT_NAME
	docker rm -v $MYSQL_CONT_NAME
}


function build {
	docker build -t jrlangford/loopback .
}

function start-server {
	docker run -it \
		--rm \
		--name $APP_CONT_NAME \
		-v $(pwd)/examples:/home/node \
		--link $MYSQL_CONT_NAME:mysql \
		-p 3000:3000 \
		jrlangford/loopback \
		bash -c "cd /home/node/getting-started && npm install && node ."
} 

function stop-server {
	docker stop $APP_CONT_NAME
	docker rm -v $APP_CONT_NAME
}

function inspect {
	docker exec -it $APP_CONT_NAME bash
}

case "$1" in
	build)
		build
		;;
        start)
		start-mysql
		start-server
		;;
	stop)
		stop-server
		stop-mysql
		;;
	inspect)
		inspect
		;;
        *)
            echo $"Usage: $0 {build|start|stop|inspect}"
            exit 1
esac
