# Install image from latest Centos 
FROM centos:latest

# Update repository and OS
RUN dnf update -y

# Copy Centreon install script 
COPY installCentreon.sh /root
RUN chmod +x /root/installCentreon.sh
