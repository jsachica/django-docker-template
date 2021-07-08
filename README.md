# Django Docker Template
This is a Django project template setup with docker for local development


## Running the project

* Bring all the services up: `docker-compose up -d --build`

The `-d` flag indicates that the services are run dettached from the current shell, so
to bring all the services down you have to run `docker-compose down`


## Accessing the django admin panel

To access the built-in django admin panel do the following:

* Bash into the container where the server is running: `docker exec -it ddt-api bash`
* Crear a superuser to access the admin panel: `python manage.py createsuperuser`. Enter all the data required for
  the user.
* Exit the container: `exit`
* Go to `http://localhost:9292/admin` and login with the user you just created

## Inspecting the database

By default, there is a service specified in the `docker-compose.yml` file that spins up a container running the 
lightweight [pgweb](https://sosedoff.github.io/pgweb/) web server which allows you to inspect all tables, data and
schema. If you have another client of preference (like [DataGrip](https://www.jetbrains.com/datagrip/)), the db service
exposes the default PostgreSQL port `5432` on the host, so you can connect through it.

The default username and password are `postgres`, and the database name is `data`.
