#!/bin/sh
docker build -t pureftpd .
docker run --rm -it --name=pureftpd pureftpd
#docker exec -it pureftpd sh