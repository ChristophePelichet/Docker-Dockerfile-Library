# Centreon 20.10 based on Centos 8 with docker

<img src="https://www.docker.com/sites/default/files/d8/2019-07/horizontal-logo-monochromatic-white.png" width="200"> 
<img src="https://static.centreon.com/wp-content/uploads/2020/04/centreon-logo.png?x61306" width="200"> 




Work Under Progress......

This script can deploy a Centreon plateforme quickly one Docker. This script is based in centOS 8 and Centreon 20.10


## Links

- Centreon
    - [Centreon website](https://www.centreon.com)
    - [Centreon documentation](https://docs.centreon.com)

- CentOS
    - [CentOS website](https://www.centos.org)

- Docker
    - [Docker website](https://www.docker.com/)

## Build Image :

### Step 1 : Variable configuration

Edit buildCentreon.sh and configure variable

**## Image**
```
imgName=''          # Image Name
imgVers=''          # Image Version
imgShortName=''     # Friendly image name used with --name switch (https://docs.docker.com/engine/reference/commandline/run/#assign-name-and-allocate-pseudo-tty---name--it)
```

**## Exposed network port**
```
httpPort=''                 # Exposed HTTP port with -p switch   (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)
httpsPort=''                # Exposed HTTPS port with -p switch  (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)
```

**## Docker Network (https://docs.docker.com/engine/reference/commandline/network)**
```
dockerNetCreate=''                  # Docker network create used with switch -b : 0 = No / 1 = Yes
dockerNetName=''                    # Docker network Name       / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetSub=''                     # Docker network subnet     / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetIpR=''                     # Docker network IP range   / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetGwa=''                     # Docker network gateway    / https://docs.docker.com/engine/reference/commandline/network_create/
```

### Step 2 : Build image

Build the image with the command : buildCentreon.sh -b

### Step 3 : Install Centreon

1. Once the container is started, connect to it with the command ``` docker exec -ti $imgShortName bash ```
2. Run ```/root/installCentreon.sh``` script
3. Finalize the installation by connecting to the url ```http:\\<your ip>``` or ```https:\\<your ip>```

## Clean Image : 

### Step 1 : Variable configuration

Edit buildCentreon.sh and configure variable

**## Docker Network (https://docs.docker.com/engine/reference/commandline/network)**
```
dockerNetClean=''                  # Docker network clean used with switch -c  : 0 = No / 1 = Yes
```

### Step 2 : Run Command
- Use  buildCentreon.sh -c for cleaning container and image 


### Task Lists

- [x] First Release
- [x] Add script to install centreon (installCentreon.sh)
- [x] Add Docker network creation
- [ ] Add Docker volume creation


