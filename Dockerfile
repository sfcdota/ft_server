FROM debian:buster
WORKDIR /dir/
COPY ./srcs/ .
RUN apt-get update -y && apt-get update -y && apt-get install -y \
	nginx php php-mysql php-fpm \
	php-curl php-gd php-intl php-mbstring php-soap \
	php-xml php-xmlrpc php-zip default-mysql-server && \
	mv -t /var/www/html/ phpMyAdmin && \
	mv wordpress/* /var/www/html/ && \
	rm /etc/nginx/sites-available/default && \
	rm /etc/nginx/sites-enabled/default && \
	mv localhost /etc/nginx/sites-available/ && \
	ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost && \
	chown -R www-data /var/www/html/* && \
	chmod -R 755 /var/www/html/* && \
	openssl req -x509 -nodes -newkey rsa:2048 \
	-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.pem \
	-subj "/C=RU/ST=Kazan/L=Kazan/O=21School/OU=cbach/CN=localhost"

EXPOSE 80 443

CMD bash boot.sh
