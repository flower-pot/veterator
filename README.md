[![Build Status](https://travis-ci.org/flower-pot/veterator.svg?branch=master)](https://travis-ci.org/flower-pot/veterator)
[![Test Coverage](https://codeclimate.com/github/flower-pot/veterator/badges/coverage.svg)](https://codeclimate.com/github/flower-pot/veterator/coverage)
[![Code Climate](https://codeclimate.com/github/flower-pot/veterator/badges/gpa.svg)](https://codeclimate.com/github/flower-pot/veterator)
[![Dependency Status](https://www.versioneye.com/user/projects/555b94fa634daa5dc80002a0/badge.svg?style=flat)](https://www.versioneye.com/user/projects/555b94fa634daa5dc80002a0)
[![security](https://hakiri.io/github/flower-pot/veterator/master.svg)](https://hakiri.io/github/flower-pot/veterator/master)

veterator
=========

Veterator is a latin word for smartypants, since this application will be a
smartass to you, telling you how much electricity, water, etc. you are using.

Current status is only recording, aggregating and visualizing data directly
with this rails app, however, the vision is to evolve to a time series forecast
application.

For a production setup refer to [doc/setup.md](./doc/setup.md)

Producers
---------

This webapp does not do much by itself. It requires producers adding data. Once
the data is received by this webapp, it is aggregated and can be viewed by
browsing to it.

You can either look at examples from the
[/doc/producer-examples](doc/producer-examples) folder or take a look at the
`Advanced Settings` subsection of any sensor.

Development
-----------

###postgres

It is recommended to use postgres as it is what is used in production. To setup
the dev environment with postgres follow these instructions.

To get started developing you will need to install docker, docker-compose and
clone the repo.

Then create the database container

	docker-compose up -d db

Then setup the database and environment

	docker-compose run web rake db:migrate

And then set the environment variables required. There is an example `.env`
file containing the required variables, you can use it as a boilerplate and set
the variables as you need them to be.

	cp .env.example .env

Then the application can be started with

	docker-compose up

And tests executed with

	docker-compose run web rake
