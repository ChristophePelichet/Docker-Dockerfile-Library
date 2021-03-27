#!/bin/bash

# Update repository and install some tools
dnf -y update

# Install langpacks ( for fix error Failed to set locale, defaulting to C.UTF-8)
dnf install langpacks-en glibc-all-langpacks -y

# Set local language
localectl set-locale LANG=en_US.UTF-8

# Install some tools
dnf -y install vim curl git mlocate screen

# Disable SELINUX
echo "Disable SELINUX"
sed -i s/^SELINUX=.*$/SELINUX=disabled/ /etc/selinux/config

# Disable Firewall
echo "Disable Firewall"
systemctl stop firewalld && systemctl disable firewall

# Install RedHat PowerTools repository
dnf -y install dnf-plugins-core epel-release && dnf config-manager --set-enabled powertools

# Install Centreon repostiory
dnf install -y http://yum.centreon.com/standard/20.10/el8/stable/noarch/RPMS/centreon-release-20.10-2.el8.noarch.rpm

# Install Centreon central and local database
dnf install -y centreon centreon-database && systemctl daemon-reload && systemctl restart mariadb

# Set services startup during system bootup
echo "date.timezone = Europe/Paris" >> /etc/php.d/50-centreon.ini && systemctl restart php-fpm

# Enable on start
systemctl enable php-fpm httpd mariadb centreon cbd centengine gorgoned snmptrapd centreontrapd snmpd

# Start Apache server before web installation 
systemctl start httpd

# Clean Centos install file 
rm -rf /root/anaconda* && rm /root/original-ks.cfg

# Clean repository cache
dnf clean all
