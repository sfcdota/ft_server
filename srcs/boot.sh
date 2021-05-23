service mysql start
mysql -u root --skip-password -e "\
			CREATE DATABASE wordpress;\
			GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';\
			UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';\
			FLUSH PRIVILEGES;"
service php7.3-fpm start
service nginx start
sleep infinity
