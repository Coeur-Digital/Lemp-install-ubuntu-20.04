#!/bin/bash

check_exit_status() {

	if [ $? -eq 0 ]; then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Process Failed!"
		echo

		read -p "The last command exited with an error. Exit script? (yes/no) " answer

		if [ "$answer" == "yes" ]; then
			exit 1
		fi
	fi
}

greeting() {

	echo
	echo "Hello, $USER. Let's update this system. Please prepare Mysql password"
	echo
}

update() {

	sudo apt update;
	check_exit_status

	sudo apt upgrade -y;
	check_exit_status

}

nginx() {

	sudo apt install nginx -y;
	check_exit_status
	sudo systemctl enable nginx;
	check_exit_status
	sudo systemctl start nginx;
	check_exit_status
	sudo systemctl status nginx;

	check_exit_status
}
mariadb() {
	sudo apt install mariadb-server mariadb-client -y;
	check_exit_status

	systemctl status mariadb;
	check_exit_status
	sudo systemctl enable mariadb;
	check_exit_status
	
}
php73() {
sudo apt-get install software-properties-common -y;
sudo add-apt-repository ppa:ondrej/php -y;
sudo apt-get update;
check_exit_status
	sudo apt install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php7.3-mbstring php7.3-xml php7.3-gd php7.3-curl -y
	check_exit_status
	sudo systemctl enable php7.3-fpm
	check_exit_status
	systemctl status php7.3-fpm
	check_exit_status

}

leave() {

	echo
	echo "--------------------"
	echo "- Install Complete! by Coeur Digital -"
	echo "--------------------"
	echo
	exit
}

greeting
update
nginx
mariadb
php73
leave
