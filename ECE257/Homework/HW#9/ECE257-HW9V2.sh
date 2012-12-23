#!/bin/bash

#defines the main variables for the program

VER="ECE 257 H9 v0.2"
DIR="/tmp/$(whoami)/ece257"

NOTE=""

MSG=""

#Download Locations
DLprce="http://downloads.sourceforge.net/project/pcre/pcre/8.33/pcre-8.33.tar.gz"
DLhttpd="http://apache.osuosl.org/httpd/httpd-2.4.7.tar.gz"
DLapr="http://www.eng.lsu.edu/mirrors/apache/apr/apr-1.5.0.tar.gz" 
DLaprutil="http://www.eng.lsu.edu/mirrors/apache/apr/apr-util-1.5.3.tar.gz" 
DLmaria="http://ftp.osuosl.org/pub/mariadb/mariadb-5.5.34/kvm-tarbake-jaunty-x86/mariadb-5.5.34.tar.gz"
DLphp="http://www.php.net/get/php-5.5.6.tar.gz/from/a/mirror"


#will initilize the folder paths for the program
init () {

if [ ! -e ${DIR}/download ]
then
	mkdir -p ${DIR}/download
fi

if [ ! -e ${DIR}/package ]
then
	mkdir -p ${DIR}/package
fi

}

delete () {

	rm -rf ${DIR}/package/*

}

#Instert your functions right here
#you type wrong number
#0
badchoice () { MSG="I did not ask you to type that, all well Please Try Again :D" ; } 
#1
httpd() {
	#grab pcre due to dependence
	clear
	echo 

	if [ -e ${DIR}/download/pcre.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLprce -O ${DIR}/download/pcre.tar.gz
	fi

	echo "Extracting pcre to ${DIR}/package/pcre"
	if [ ! -d ${DIR}/package/pcre/ ]
	then
		tar zxf ${DIR}/download/pcre.tar.gz -C ${DIR}/package/
		mv ${DIR}/package/pcre* ${DIR}/package/pcre
	else
		echo "pcre already exist, skipping"
	fi
	echo -e "Finished Extacting pcre\n\n"





	#Download httpd set
	if [ -e ${DIR}/download/httpd.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLhttpd -O ${DIR}/download/httpd.tar.gz
	fi

	echo "Extracting httpd to ${DIR}/package/httpd"
	if [ ! -d ${DIR}/package/httpd/ ]
	then
		tar zxf ${DIR}/download/httpd.tar.gz -C ${DIR}/package/ httpd-2.4.7
		mv ${DIR}/package/httpd* ${DIR}/package/httpd
	else
		echo "httpd already exist, skipping"
	fi
	echo -e "Finished Extacting https\n\n"


	#Download apr set
	if [ -e ${DIR}/download/apr.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLapr -O ${DIR}/download/apr.tar.gz
	fi
	
	echo "Extracting apr to ${DIR}/package/apr"
	if [ ! -d ${DIR}/package/httpd/srclib/apr/ ]
	then
		tar zxf ${DIR}/download/apr.tar.gz -C ${DIR}/package/httpd/srclib/
		mv ${DIR}/package/httpd/srclib/apr-1* ${DIR}/package/httpd/srclib/apr
	else
		echo "apr already exist, skipping"
	fi
	echo -e "Finished Extacting apr\n\n"

	#Download apr utilities set
	if [ -e ${DIR}/download/apr-util.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLaprutil -O ${DIR}/download/apr-util.tar.gz
	fi

	echo "Extracting apr-util to ${DIR}/package/apr-util"
	if [ ! -d ${DIR}/package/httpd/srclib/apr-util ]
	then
		tar zxf ${DIR}/download/apr-util.tar.gz -C ${DIR}/package/httpd/srclib/
		mv  ${DIR}/package/httpd/srclib/apr-util* ${DIR}/package/httpd/srclib/apr-util
	else
		echo "apr-util already exist, skipping" 
	fi        
	echo -e "Finished Extacting apr-util\n\n" 


#setup and install
echo "Finished Downloading and preparing each package"
echo "Now press enter to continue"
read space

echo "Setting up and installing pcre"
cd ${DIR}/package/pcre
./configure --prefix=${DIR}/opt/pcre && make && make install

echo "Setting up httpd"
cd ${DIR}/package/httpd
./configure --prefix=${DIR}/opt/httpd --with-pcre=${DIR}/opt/pcre && make && make install


#Finished
echo "Finished with setting up httpd"
echo "Now press enter to continue"
read space

}

#
# Download and install mysql
#
mysql() {
#Due to mysql oracle  issues, mysql will be grabed through mariadb since maria is mysql but forked due to oracle

	if [ -e ${DIR}/download/maria-db.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLmaria -O ${DIR}/download/maria-db.tar.gz
	fi

	echo "Extracting Mariadb(mysql) to ${DIR}/package/mariadb"
	if [ ! -d ${DIR}/package/maria/ ]
	then
		tar zxf ${DIR}/download/maria-db.tar.gz -C ${DIR}/package/
		mv ${DIR}/package/maria* ${DIR}/package/maria
	else
		echo "mariadb already exist, skipping"
	fi
	echo -e "Finished Extacting mariadb\n\n"

#setup and install finished
echo "Finished Downloading and preparing MariaDB"
echo "Now press enter to continue"
read space

	cd ${DIR}/package/maria/
	BUILD/autorun.sh
	./configure --prefix=${DIR}/opt/maria && make && make install


echo "Finished with setting up mariadb (mysql)"
echo "Now press enter to continue"
read space

}

#3
php() {

	if [ -e ${DIR}/download/php.tar.gz ] #check if file exist
	then
		echo "File Exist, skipping Download"
	else
		wget --progress=bar $DLphp -O ${DIR}/download/php.tar.gz
	fi

	echo "Extracting php to ${DIR}/package/php"
	if [ ! -d ${DIR}/package/php/ ]
	then
		tar zxf ${DIR}/download/php.tar.gz -C ${DIR}/package/
		mv ${DIR}/package/php* ${DIR}/package/php
	else
		echo "php already exist, skipping"
	fi
	echo -e "Finished Extacting php\n\n"

#setup and install finished
echo "Finished Downloading and preparing php"
echo "Now press enter to continue"
read space

	cd ${DIR}/package/php/
	BUILD/autorun.sh
	./configure --prefix=${DIR}/opt/php --with-apxs2=${DIR}/opt/apxs --with-mysql=${DIR}/opt/mysql --with-mysqli=${DIR}/opt/mysql/bin/mysql_config
	 make && make install


echo "Finished with setting up mariadb (mysql)"
echo "Now press enter to continue"
read space


	wget http://us2.php.net/distributions/php-5.4.9.tar.gz 
	tar zxf php*.tar.gz -C ${DIR}/package
	cd ${DIR}/package/php-5.4.9/
	./configure --prefix=${DIR}/php --with-apxs2=${DIR}/bin/apxs --with-mysql=${DIR}/mysql --with-mysqli=${DIR}/mysql/bin/mysql_config
echo "Finished with setting up php"
echo "Now press enter to continue"
read space
}


########################################################################
## Main Menu


menu () {
	clear
	echo    $VER
	echo "######################################################"
	echo "######### Welcome to ECE 257 HW 9  installer #########"
	echo "######################################################"
	echo "#### if you want to see more of these nice scripts ###"
	echo "########### help me with a little donation ###########"
	echo "###########################JK#########################"
	echo    $VER
	echo	"Install location:"$DIR
	echo
	echo    "Select your task:"
	echo    "(highly recommend going inorder from 1,2,3,... for a easy setup)"
	echo
	echo    "1 Apache2 Httpd"
	echo    "2 Mysql"
	echo    "3 php"
	echo    "4 delete work"
	echo
	echo    "xExit"
	echo
	echo    $MSG
	echo
	echo "Select by pressing the number and then hit ENTER" ;
}




init

while  true
do

	menu


	read answer


	MSG=



	case $answer in
		1) httpd;;
		2) mysql;;
		3) php;;
     	4) delete;;

     x|X) break;;


	*) badchoice;;

esac



done
