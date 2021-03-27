#!/bin/bash

imgName='centreon2010'          # Image Name
imgVers='v1.0'                  # Image Version
imgShortName='centreon'         # Friendly image name used with --name
httpPort='8080'                 # HTTP port
httpsPort='4343'                # HTTPS port

# Build image
echo "Build Image"
docker build -t $imgName:$imgVers .

# Starting Container
echo "Start Container"
docker run -itd --name $imgShortName --restart always -p $httpPort:80 -p $httpsPort:443 --privileged $imgName:$imgVers /usr/sbin/init  

# Connect Network
echo "Switch Network"
docker network connect centreon_default $imgShortName
docker network disconnect bridge $imgShortName





