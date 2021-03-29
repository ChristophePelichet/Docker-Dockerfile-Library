# Centreon 20.10 based on Centos 8

Work Under Progress......




## Build Image :

### Step 1 : Variable configuration

**Edit buildCentreon.sh and configure variable**


### Step 2 : Build image

Build the image with the command : buildCentreon.sh -b

### Step 3 : Install Centreon

Once the container is started, connect to it with the command ''' docker exec -ti **<$imgShortName>** bash '''
3. Run /root/installCentreon.sh
4. Finalize the installation by connecting to the url http:\\<your ip>:yourport

## Clean ImageFor cleaning : 

### Step 1 : Variable configuration

**Edit buildCentreon.sh and configure variable**

### Step 2 : Run Command
- Use  buildCentreon.sh -c for cleaning container and image 


