#!/bin/bash

docker compose stop $1 && docker compose rm -f $1  && docker compose create $1  && docker compose start $1
