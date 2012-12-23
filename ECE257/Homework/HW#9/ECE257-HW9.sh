#!/bin/sh

#defines the main variables for the program

VER="ECE 257 H9 v0.1"
DIR="/tmp/$(whoami)/ece257"

NOTE="highly recommend going inorder from 1,2,3,... for a easy setup"

amenu=" 1 Apache2 Httpd" ;
bmenu=" 2 Mysql" ; 
cmenu=" 3 php" ; 

MSG=

#Instert your functions right here
#you type wrong number
#0
badchoice () { MSG="I did not ask you to type that, all well Please Try Again :D" ; } 
#1
httpd() {
#grab pcre due to dependence
wget --progress=bar "ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.32.tar.gz" -o ${DIR}/download/pcre.tar.gz
tar zxf ${DIR}/download/pcre.tar.gz -C ${DIR}/package/pcre
wget --progress=bar http://apache.osuosl.org/httpd/httpd-2.4.3.tar.gz -O ${DIR}/download/httpd.tar.gz
wget --progress=bar http://www.eng.lsu.edu/mirrors/apache/apr/apr-util-1.5.1.tar.gz -O ${DIR}/download/apr-util.tar.gz
wget --progress=bar http://www.eng.lsu.edu/mirrors/apache/apr/apr-1.4.6.tar.gz -O ${DIR}/download/apr.tar.gz
tar zxf ${DIR}/download/httpd.tar.gz -C ${DIR}/package/httpd
tar zxf -O ${DIR}/download/apr-util.tar.gz -C ${DIR}/package/httpd-2.4.3/srclib/apr-util
tar zxf -O ${DIR}/download/apr.tar.gz -C ${DIR}/package/httpd-2.4.3/srclib/apr
}
#2--progress=bar
mysql() {
wget http://dev.mysql.com/get/Downloads/MySQL-5.1/mysql-5.1.66.tar.gz
tar zxf mysql*.tar.gz -C ${DIR}/package
cd ${DIR}/package/mysql-5.1.66/
./configure --prefix=${DIR}/mysql && make && make install
}
#3
php() {
wget http://us2.php.net/distributions/php-5.4.9.tar.gz
tar zxf php*.tar.gz -C ${DIR}/package
cd ${DIR}/package/php-5.4.9/
./configure --prefix=${DIR}/php --with-apxs2=${DIR}/bin/apxs --with-mysql=${DIR}/mysql --with-mysqli=${DIR}/mysql/bin/mysql_config
}


########################################################################
## Main Menu


apick () { httpd ; }
bpick () { mysql ; }
cpick () { php ; }




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
echo    $NOTE
echo    $amenu
echo    $bmenu
echo    $cmenu
echo
echo
echo    "xExit"
echo
echo    $MSG
echo
echo Select by pressing the number and then hit ENTER ;
}






while  true
do

menu


read answer


  MSG=



  case $answer in
     1) apick;;
     2) bpick;;
     3) cpick;;

     x|X) break;;


        *) badchoice;;
 
 esac



done
