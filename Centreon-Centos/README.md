# Centreon 20.10 based on Centos 8

Work Under Progress......




## Build Image :

### Step 1 : Variable configuration

Edit buildCentreon.sh and configure variable

**Image**
```
imgName=''          # Image Name
imgVers=''          # Image Version
imgShortName=''     # Friendly image name used with --name switch (https://docs.docker.com/engine/reference/commandline/run/#assign-name-and-allocate-pseudo-tty---name--it)
```

**Exposed network port**
```
httpPort=''                 # Exposed HTTP port with -p switch   (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)
httpsPort=''                # Exposed HTTPS port with -p switch  (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)
```

**Docker Network (https://docs.docker.com/engine/reference/commandline/network)**
```
dockerNetCreate='1'                 # Docker network create used with switch -b : 0 = No / 1 = Yes
dockerNetName='centreon_default'    # Docker network Name       / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetSub='172.21.0.0/16'        # Docker network subnet     / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetIpR='172.21.0.214/32'      # Docker network IP range   / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetGwa='172.21.0.1'           # Docker network gateway    / https://docs.docker.com/engine/reference/commandline/network_create/
```

### Step 2 : Build image

Build the image with the command : buildCentreon.sh -b

### Step 3 : Install Centreon

1. Once the container is started, connect to it with the command ``` docker exec -ti $imgShortName bash ```
2. Run ```/root/installCentreon.sh``` script
3. Finalize the installation by connecting to the url ```http:\\<your ip>``` or ```https:\\<your ip>```

## Clean ImageFor cleaning : 

### Step 1 : Variable configuration

Edit buildCentreon.sh and configure variable

**Docker Network (https://docs.docker.com/engine/reference/commandline/network)**
```
dockerNetClean='0'                  # Docker network clean used with switch -c  : 0 = No / 1 = Yes
```

### Step 2 : Run Command
- Use  buildCentreon.sh -c for cleaning container and image 


