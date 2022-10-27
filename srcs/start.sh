# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mel-kada <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/08/29 18:42:54 by mel-kada          #+#    #+#              #
#    Updated: 2020/08/29 18:43:00 by mel-kada         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SSL_CERTS=/etc/ssl/certs/localhost.pem
SSL_CERTS_KEY=/etc/ssl/certs/localhost-key.pem

if [[ ! -f "$SSL_CERTS" ]] || [[ ! -f "$SSL_CERTS_KEY" ]]
then
	echo "SSL certs does not exists boyzzz"
	chmod +x mkcert
	./mkcert -install
	./mkcert localhost

	mv localhost.pem /etc/ssl/certs/
	mv localhost-key.pem /etc/ssl/certs/
fi

service nginx restart
service php7.3-fpm start
service mysql start

mysql -u root < create_database

tail #-f /var/log/nginx/access.log /var/log/nginx/error.log

