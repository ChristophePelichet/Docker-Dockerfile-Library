# Centreon 20.10 based on Centos 8

Work Under Progress......




## Build Image :

### Step 1 : Variable configuration

Edit buildCentreon.sh and configure variable

**Image**
```
imgName=''          # Image Name
imgVers=''          # Image Version
imgShortName=''     # Friendly image name used with --name (https://docs.docker.com/engine/reference/commandline/run/#assign-name-and-allocate-pseudo-tty---name--it)
```

### Step 2 : Build image

Build the image with the command : buildCentreon.sh -b

### Step 3 : Install Centreon

1. Once the container is started, connect to it with the command ``` docker exec -ti $imgShortName bash ```
2. Run ```/root/installCentreon.sh``` script
3. Finalize the installation by connecting to the url ```http:\\<your ip>``` or ```https:\\<your ip>```

## Clean ImageFor cleaning : 

### Step 1 : Variable configuration

**Edit buildCentreon.sh and configure variable**

### Step 2 : Run Command
- Use  buildCentreon.sh -c for cleaning container and image 


