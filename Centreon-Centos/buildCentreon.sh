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
imgShortName='centreon'         # Friendly image name used with --name

# Network Port 
httpPort='8080'                 # HTTP port
httpsPort='4343'                # HTTPS port

# Docker Volume
#dockerVolumeCreate='1'              # For switch -b : Create Docker Volume  0 = No / 1 = Yes
#dockerVolumeClean='0'               # For switch -c : Clean Docker Volume   0 = No / 1 = Yes
dockerVolumeName='centreon_data'

# Docker Network 
dockerNetworkCreate='1'             # For switch -b : Create Docker Network  0 = No / 1 = Yes
dockerNetworkClean='0'              # For switch -c : Clean Docker Volume    0 = No / 1 = Yes
dockerNetworkName='centreon_default'

#######################################################
################### Start Scripts #####################
#######################################################

# if [ -z $scriptSwitch ]; then
#     echo " Please choice your script option : "
#     echo " -b   -> For build image"
#     echo " -c   -> For clean image"
# fi


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
    if [ $dockerNetworkCreate == '0' ]; then
        echo "Step 3 : No creation of a Docker network"
    else 
        echo "Step 3 : Create Docker network"

        # Check if Docker network exist
        resultDockerNetExist=$(docker network ls | cut -d ' ' -f4 | grep -i $dockerNetworkName)

        if [ -z $resultDockerNetExist ]; then
        docker network create -d bridge \
        --subnet=172.21.0.0/16 \
        --ip-range=172.21.0.214/32 \
        --gateway=172.21.0.1 \
        $dockerNetworkName
        else
        echo " Docker network alredy exist !"
        fi
    fi
    # Starting container
    echo "Step 4 : Starting container"
    docker run -itd --name $imgShortName --restart always -p $httpPort:80 -p $httpsPort:443 --privileged $imgName:$imgVers /usr/sbin/init  

    # Connect network
    if [ $dockerNetworkCreate == '1' ]; then
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





