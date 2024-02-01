FROM ubuntu:latest
RUN apt-get update ; apt-get install apache2 -y
COPY . /var/www/html
EXPOSE 80
ENTRYPOINT ["apachectl","-D","FOREGROUND"]
