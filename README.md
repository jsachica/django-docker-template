# django-template
Django project template with docker

## Dev deployment

### Initial Setup
* #### Step 1:
  Bring all the services up: `docker-compose up -d --build`

* #### Step 2:
  Bash into the container where the server is running: `docker exec -it ct-api bash`

* #### Step 3:
  Collect static files: `python manage.py collectstatic`

* #### Step 4:
  Run migrations: `python manage.py migrate`

* #### Step 5:
  Crear a superuser to access the admin panel: `python manage.py createsuperuser`. Enter all the data required for the user.

* #### Step 6:
  Exit the container: `exit`


## Prod deployment
