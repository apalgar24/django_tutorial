FROM python:3
WORKDIR /usr/src/app
MAINTAINER Adrian Palomino García
RUN pip install django mysqlclient && git clone https://github.com/apalgar24/docker_django.git /usr/src/app && mkdir static && apt-get clean && rm -rf /var/lib/apt/lists/*
#ADD django_polls.sh /usr/src/app
RUN chmod +x /usr/src/app/django_polls.sh
ENV ALLOWED_HOSTS=*
ENV HOST=mariadb
ENV USUARIO=django
ENV CONTRA=django
ENV BASE_DATOS=django
ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_EMAIL=admin@example.org
CMD ["/usr/src/app/django_polls.sh"]
