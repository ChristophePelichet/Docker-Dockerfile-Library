# Centreon 20.10 based on Centos 8

Work Under Progress......

if you don't want to use a specific Docker network comment in buildCentreon.sh this part 

# Connect Network
echo "Switch Network"
docker network connect centreon_default $imgShortName
docker network disconnect bridge $imgShortName

For install :

1 - Edit buildCentreon.sh and edit the variable
2 - Run buildCentreon.sh -b
4 - Once the container is started, connect to it with the command : docker exec -ti $imgShortName bash 
5 - Run /root/installCentreon.sh
6 - Finalize the installation by connecting to the url http:\\<your ip>:yourport

For cleaning : 

1 - Use  buildCentreon.sh -b for cleaning container and image 


