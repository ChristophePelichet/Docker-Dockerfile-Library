#!/bin/bash

imgName='centreon2010'
imgVers='v1.0'
imgShortName='centreon'


docker stop $imgShortName
docker rm $imgShortName
docker rmi $imgName:$imgVers