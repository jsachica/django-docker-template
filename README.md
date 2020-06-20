# django-template
Django project template with docker

## Dev deployment

### Initial Setup
* #### Step 1:
  Delete the folders 'webproject-$dbname' that won't be used and only leave the one that will be used, rename it to 'webproject' and cd into it: `cd webproject`

* #### Step 2:
  Bring up the django service: `docker-compose -f docker-compose.dev.yml up -d --build django`

* #### Step 3:
  Bash into the container where the server is running: `docker exec -u root -it django-container bash`

* #### Step 4:
  Create a new django project in the src/ folder and give it a name $projectName: `cd .. && django-admin startproject $projectName src`

* #### Step 5:
  Exit the container: `exit`

* #### Step 6:
  Bring down the service: `docker-compose -f docker-compose.dev.yml down`

* #### Step 7:
  Replace the project name in the CMD of the Dockerfile: `CMD gunicorn $projectName.wsgi:application --bind 0.0.0.0:8000`

* #### Step 8:
  Open the docker-compose.dev.yml file and comment the command of the django service (add the '#' characted): `# command: tail -f /dev/null`

* #### Step 9:
  Bring all the services back up again: `docker-compose -f docker-compose.dev.yml up -d --build`

* #### Step 10:
  Bash into the container where the server is running: `docker exec -u root -it django-container bash`

### These following steps:
* #### Step 11:
  Collect static files: `python manage.py collectstatic`

* #### Step 12:
  Run migrations: `python manage.py migrate`

* #### Step 13:
  Crear a superuser to access the admin panel: `python manage.py createsuperuser`. Enter all the data required for the user.

* #### Step 14:
  Exit the container: `exit`


## Prod deployment
