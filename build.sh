#!/bin/bash
export TWITTER_CONSUMER_KEY=xxxx
export TWITTER_CONSUMER_SECRET=xxxx
export TWITTER_USER_TOKEN=xxxx
export TWITTER_USER_SECRET=xxxx
export DB_PW=admin
export ADMIN_PW=admin
export TCAT_PW=tcat
docker-compose pull
docker-compose build

