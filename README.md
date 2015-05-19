[![Build Status](https://travis-ci.org/flower-pot/veterator.svg?branch=master)](https://travis-ci.org/flower-pot/veterator)
[![Coverage Status](https://coveralls.io/repos/flower-pot/veterator/badge.svg?branch=master)](https://coveralls.io/r/flower-pot/veterator?branch=master)
[![Test Coverage](https://codeclimate.com/github/flower-pot/veterator/badges/coverage.svg)](https://codeclimate.com/github/flower-pot/veterator/coverage)

veterator
=========

Veterator is a latin word for smartypants, since this application will be a
smartass to you, telling you how much electricity, water, etc. you are using.

Current status is only recording and analysing data directly with this rails
app, however, the vision is to evolve to a data warehouse like application
aggregating data in multiple dimensions.

Development
-----------

To get started developing you will need to install docker and docker-compose.

On ubuntu you can do so with (run as root)

	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
	sh -c "echo deb https://get.docker.io/ubuntu docker main > /etc/apt/sources.list.d/docker.list"
	apt-get update
	apt-get install lxc-docker
	curl -L https://github.com/docker/compose/releases/download/1.1.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
	chmod +x /usr/local/bin/docker-compose

Then create the database container

	sudo docker-compose up -d db

Then setup the database and environment

	sudo docker-compose run web rake db:create
	sudo docker-compose run web rake db:migrate

And then set the environment variables required. There is an example `.env`
file containing the required variables, you can use it as a boilerplate and set
the variables as you need them to be.

	cp .env.example .env

Then the application can be started with

	sudo docker-compose up
