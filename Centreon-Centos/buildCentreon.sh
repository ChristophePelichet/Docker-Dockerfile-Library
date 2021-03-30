#!/bin/bash


########################################################
######################## Path ##########################
########################################################



#######################################################
###################### Variables ######################
#######################################################

## Scripts
scriptSwitch=$1

## Images
imgName='centreon2010'          # Image Name
imgVers='v1.0'                  # Image Version
imgShortName='centreon'         # Friendly image name used with --name switch (https://docs.docker.com/engine/reference/commandline/run/#assign-name-and-allocate-pseudo-tty---name--it)

# Exposed network port 
httpPort='8080'                 # Exposed HTTP port with -p switch   (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)
httpsPort='4343'                # Exposed HTTPS port with -p switch  (https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p---expose)

## Docker volume (https://docs.docker.com/engine/reference/commandline/volume)
dockerVolCreate='1'                 # Docker volume create used with switch -b : Create Docker Volume  0 = No / 1 = Yes
dockerVolClean='0'                  # Docker volume clean used with switch -c  : Clean Docker Volume   0 = No / 1 = Yes
dockerVolName='centreon_data'       # Docker volume name    /  https://docs.docker.com/engine/reference/commandline/volume_create/ 

## Docker network (https://docs.docker.com/engine/reference/commandline/network)
dockerNetCreate='1'                 # Docker network create used with switch -b : 0 = No / 1 = Yes
dockerNetClean='0'                  # Docker network clean used with switch -c  : 0 = No / 1 = Yes
dockerNetName='centreon_default'    # Docker network name       / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetSub='172.21.0.0/16'        # Docker network subnet     / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetIpR='172.21.0.214/32'      # Docker network IP range   / https://docs.docker.com/engine/reference/commandline/network_create/
dockerNetGwa='172.21.0.1'           # Docker network gateway    / https://docs.docker.com/engine/reference/commandline/network_create/


#######################################################
################### Start Scripts #####################
#######################################################

case "$1" in

# Build image
-b) echo "Bulding Centreon Image"
    # Build image
    echo "Step 1 : Build Image"
    docker build -t $imgName:$imgVers .

    # Create Docker volume
    if [ $dockerVolCreat == '0' ]; then
        echo "Step 3 : No creation of a Docker volume"
    else 
        echo "Step 3 : Create Docker volume"

        # Check if Docker volume exist
        resultDockerVolExist=$(docker volume ls | cut -d ' ' -fg | grep -i $dockerVolName)

        if [ -z $resultDockerVolExist ]; then
        docker volume create $dockerVolName
        else
        echo " Docker network volume exist !"
        fi
    fi

    # Create Docker network
    if [ $dockerNetCreate == '0' ]; then
        echo "Step 3 : No creation of a Docker network"
    else 
        echo "Step 3 : Create Docker network"

        # Check if Docker network exist
        resultDockerNetExist=$(docker network ls | cut -d ' ' -f4 | grep -i $dockerNetName)

        if [ -z $resultDockerNetExist ]; then
        docker network create -d bridge \
        --subnet=$dockerNetSub \
        --ip-range=$dockerNetIpR \
        --gateway=$dockerNetGwa \
        $dockerNetName
        else
        echo " Docker network alredy exist !"
        fi
    fi
    
    # Starting container
    echo "Step 4 : Starting container"
    docker run -itd --name $imgShortName --restart always -p $httpPort:80 -p $httpsPort:443 --privileged $imgName:$imgVers /usr/sbin/init  

    # Connect network
    if [ $dockerNetCreate == '1' ]; then
        echo "Step 5 : Switching network"
        docker network connect centreon_default $imgShortName
        docker network disconnect bridge $imgShortName
    fi
    ;;


-c) echo "Remove and clean Centreon image"

    # Stop container
    echo "Step 1 : Stoping container"
    docker stop $imgShortName

    # Remove container
    echo "Step 2 : Removing container"
    docker rm $imgShortName

    # Remove image
    echo "Step 3 : Removing Image"
    docker rmi $imgName:$imgVers

    # Remove volume
    if [ $dockerVolClean == "1" ]; then 
        echo " Step 4 : Removing Docker volume"
        docker volume rm $dockerVolName
    else
        echo " Step 4 : Not removing Docker volume"
    fi

    # Remove Docker Network
    if [ $dockerNetClean == "1" ]; then
        echo " Step 5 : Removing Docker network"
        docker network rm $dockerNetName
    else
        echo " Step 5 : Not removing Docker network"
    fi
    ;;

*)  echo "Help"
    echo "----------"
    echo " Please choice your script option : "
    echo " -b   -> For build image"
    echo " -c   -> For clean image"
    ;;

esac






#######################################################
#################### Ens Scripts ######################
#######################################################





