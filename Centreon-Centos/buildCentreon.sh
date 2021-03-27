#!/bin/bash

imgName='centreon2010'
imgVers='v1.0'
imgShortName='centreon'

# Build image
echo "Build Image"
docker build -t $imgName:$imgVers .

echo "First Run"
docker run -itd --name $imgShortName --restart always -p 8080:80 -p 4443:443 --privileged $imgName:$imgVers /usr/sbin/init  

# Connect Network
echo "Switch Network"
docker network connect centreon_default $imgShortName
docker network disconnect bridge $imgShortName





