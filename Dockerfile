# pull official base image
FROM python:3.10-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
   && apk add postgresql-dev gcc musl-dev jpeg-dev zlib-dev

# install python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip install --upgrade pip
RUN pip install -U setuptools
RUN pip install --no-cache-dir -r requirements.txt

# Install dotenv module
RUN pip install python-dotenv


# copy project
COPY . .

#EXPOSE 8000
#RUN chmod +x deployment-service
#CMD ["python", "manage.py", "migrate"]
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

# command to run the application (chatgpt update)
CMD ["gunicorn", "innovatics_elearning.wsgi:application", "--bind", "0.0.0.0:8000"]
