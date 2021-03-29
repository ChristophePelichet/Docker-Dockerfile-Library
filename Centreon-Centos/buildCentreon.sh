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

# Docker Volume
#dockerVolumeCreate='1'              # For switch -b : Create Docker Volume  0 = No / 1 = Yes
#dockerVolumeClean='0'               # For switch -c : Clean Docker Volume   0 = No / 1 = Yes
dockerVolumeName='centreon_data'

# Docker Network (https://docs.docker.com/engine/reference/commandline/network)
dockerNetCreate='1'                 # Docker network create used with switch -b : 0 = No / 1 = Yes
dockerNetClean='0'                  # Docker network clean used with switch -c  : 0 = No / 1 = Yes
dockerNetName='centreon_default'    # Docker network Name       / https://docs.docker.com/engine/reference/commandline/network_create/
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
    #echo "Step 2 : Create Docker data volume"
    #docker volume create $volumeName

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
    echo "Step 1 : Stop container"
    docker stop $imgShortName

    # Remove container
    echo "Step 2 : Remove container"
    docker rm $imgShortName

    # Remove image
    echo "Step 3 : Remove Image"
    docker rmi $imgName:$imgVers

    # Remove Docker Network
    if [ $dockerNetClean == "1" ]; then
        echo " Step 4 : Remove Docker network"
        docker network rm $dockerNetName
    else
        echo " Step 4 : Not remove Docker network"
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





