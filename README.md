# django-template-postgres
Django project template with docker and PostgreSQL

## Dev deployment

### Initial Setup
* #### Step 1:
  Bring up the web service: `docker-compose -f docker-compose.dev.yml up -d --build web`

* #### Step 2:
  Bash into the container where the server is running: `docker exec -u root -it web-container bash`

* #### Step 3:
  Create a new django project in the src/ folder and give it a name $projectName: `cd .. && django-admin startproject $projectName src`

* #### Step 4:
  Exit the container: `exit`

* #### Step 5:
  Bring down the service: `docker-compose -f docker-compose.dev.yml down`

* #### Step 6:
  Replace the project name in the CMD of the Dockerfile: `CMD gunicorn $projectName.wsgi:application --bind 0.0.0.0:8000`

* #### Step 7:
  Open the docker-compose.dev.yml file.

  Delete the command of the web service: `command: tail -f /dev/null`

  Delete the following volume of the web service: `- ./webproject/:/home/website/src/`

  Uncomment the following two named volumes (simply delete the '#' character):
  ````
  #      - media-files:/home/website/src/media/
  #      - static-files:/home/website/src/static/
  ````

* #### Step 8:
  Bring all the services back up again: `docker-compose -f docker-compose.dev.yml up -d --build`

* #### Step 9:
  Bash into the container where the server is running: `docker exec -u root -it web-container bash`

* #### Step 10:
  Collect static files: `python manage.py collectstatic`

### These following steps will need to be redone once the project is set to use the postgres database:
* #### Step 11:
  Run migrations: `python manage.py migrate`

* #### Step 12:
  Crear a superuser to access the admin panel: `python manage.py createsuperuser`. Enter all the data required for the user.

* #### Step 13:
  Exit the container: `exit`


## Prod deployment
