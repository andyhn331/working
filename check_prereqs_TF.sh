#!/bin/bash
# Author: Andy Hawkins
# Date: 5 Jun 2019
# Version: 0.1
# To do?
# Just install packages that are missing or lower version than required?

LIST="curl bash iptables-services net-tools ntp nscd openssh-clients openssh-server postfix python rpm-build rsync sudo sysstat wget yum-utils"
INPUT=./vers_driver
#TMP=./vers.tmp
#rm $TMP; touch $TMP

tput clear

cat << EOF > $INPUT
curl 7.29
bash 4.0
iptables-services 1.4.21
net-tools 2.0
ntp 4.2.6
nscd 2.17
openssh-clients 6.6
openssh-server 6.6
postfix 2.10
python 2.7
rpm-build 4
rsync 3.0.9
sudo 1.8.6p7
sysstat 10.1.5
wget 1.14
yum-utils 1.1.31
EOF

for name in $LIST
do
	rpm -q $name > /dev/null 2>&1
	if [ $? -eq 1 ]; then
		echo "$name is not installed, please install"
	else
		echo "Package `rpm -q $name` " > /dev/null @>&1
		vers=`rpm -q $name` 
		# Will adapt to do more effective pattern matching - to only alert when too low
		#req=`awk /$name/'{print $2}' $INPUT`
		#if [ $req > $vers ]; then
		#	echo "$name is  at a supported version, you're good"
		#else
		echo -n "You're running $vers" ; awk  /$name/'{print ",you need", $1, $2, "or later"}' $INPUT 
		#fi
	fi
done
