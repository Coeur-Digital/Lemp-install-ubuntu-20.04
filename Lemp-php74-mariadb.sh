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

	sudo apt intall nginx -y;
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
	

	echo
	echo "You Will need to enter New password"
	echo
	echo
	exit;
	sudo mysql_secure_installation;
	check_exit_status
	mariadb --version;
	check_exit_status
}
php7.4() {

	sudo apt install php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl -y
	check_exit_status
	sudo systemctl enable php7.4-fpm
	check_exit_status
	systemctl status php7.4-fpm
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
php7.4
leave
