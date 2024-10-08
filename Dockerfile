FROM ubuntu

WORKDIR /src

RUN apt update
RUN apt -y upgrade
RUN apt -y install python3 python3-pip
RUN apt -y install python3-django

COPY . .

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8080"]