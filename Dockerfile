FROM debian:buster

LABEL maintainer = "cbach"

WORKDIR /dir/

RUN apt-get update -y

RUN apt-get upgrade -y

RUN apt-get install nginx -y

RUN apt-get install -y \
	php php-mysql php-fpm \
	php-curl php-gd php-intl php-mbstring php-soap \
	php-xml php-xmlrpc php-zip default-mysql-server

COPY ./srcs/ .

EXPOSE 80 443

CMD bash boot.sh
