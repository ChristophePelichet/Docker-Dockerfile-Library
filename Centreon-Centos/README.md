# Centreon 20.10 based on Centos 8

Work Under Progress......




## Build Image :

### Step 1 : Set Variable

**Edit buildCentreon.sh and edit variable**





### Step 2 : Run script
2 - Run buildCentreon.sh -b
4 - Once the container is started, connect to it with the command : docker exec -ti $imgShortName bash 
5 - Run /root/installCentreon.sh
6 - Finalize the installation by connecting to the url http:\\<your ip>:yourport

## Clean ImageFor cleaning : 

### Step 1 : Set Variable

### Step 2 : Run Command
- Use  buildCentreon.sh -c for cleaning container and image 


