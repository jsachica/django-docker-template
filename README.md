# django-template
Django project template with docker

## Dev deployment

### Initial Setup
* #### Step 1:
  Bring all the services up: `docker-compose -f docker-compose.dev.yml up -d --build`

### These following steps are optional:
* #### Step 2:
  Bash into the container where the server is running: `docker exec -u root -it django-container bash`

* #### Step 3:
  Collect static files: `python manage.py collectstatic`

* #### Step 4:
  Run migrations: `python manage.py migrate`

* #### Step 5:
  Crear a superuser to access the admin panel: `python manage.py createsuperuser`. Enter all the data required for the user.

* #### Step 6:
  Exit the container: `exit`


## Prod deployment
