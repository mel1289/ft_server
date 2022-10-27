# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mel-kada <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/29 18:42:34 by mel-kada          #+#    #+#              #
#    Updated: 2020/08/29 18:42:44 by mel-kada         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:buster

RUN apt-get update && apt-get upgrade && apt-get install -y nginx vim mariadb-server mariadb-client wget libnss3-tools
RUN apt-get install -y php php-fpm php-gd php-mysql php-cli php-curl php-json 
RUN wget https://fr.wordpress.org/latest-fr_FR.tar.gz
RUN tar -zxvf latest-fr_FR.tar.gz
RUN mv wordpress /var/www/html/wordpress
RUN chown -R www-data:www-data /var/www/html/wordpress/
RUN chmod -R 755 /var/www/html/wordpress/
RUN rm latest-fr_FR.tar.gz
RUN rm var/www/html/index.nginx-debian.html && rm /var/www/html/wordpress/wp-config-sample.php
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin
RUN rm phpMyAdmin-4.9.0.1-all-languages.tar.gz

ADD ./srcs/default ./etc/nginx/sites-available/default
ADD ./srcs/mkcert mkcert
ADD ./srcs/wp-config.php ./var/www/html/wordpress/wp-config.php
ADD ./srcs/create_database create_database
ADD ./srcs/start.sh start.sh

CMD bash start.sh
