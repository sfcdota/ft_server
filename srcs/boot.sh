#phpMyAdmin and wordpress from srcs (configured)
mv -t /var/www/html/ phpMyAdmin
mv wordpress/* /var/www/html/


#NGINX
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
mv localhost /etc/nginx/sites-available/
ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost
chown -R www-data /var/www/html/*
chmod -R 755 /var/www/html/*
openssl req -x509 -nodes -newkey rsa:2048 \
-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.pem \
-subj "/C=RU/ST=Kazan/L=Kazan/O=21School/OU=cbach/CN=localhost"


service mysql start
mysql -u root --skip-password -e "\
		CREATE DATABASE wordpress;\
		GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';
		UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';\
		FLUSH PRIVILEGES;\
		EXIT" &

service php7.3-fpm start
#nginx -g 'daemon off;'
service nginx start

bash
