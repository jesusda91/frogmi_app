# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



Se usa una arquitectura basada en DDD, usando service objects ...
Se inyectan los features obtenidos de earthquake.usgs.gov usando inserccion por lotes
Se usa patron repositorio para acceder a la db e inyeccion de dependencias para inyectar repositorios en los servicios
