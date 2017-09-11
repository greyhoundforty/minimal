#!/usr/bin/env bash

## Set some variables
sitehome='$HOME/Repos/ryantiffanydotme'
appname='ryantiffanydotme'

build_site() { 
cd "$sitehome"
rm -rf web
jekyll build -q -d web
}

docker_push() { 
docker build -t hyperjekyll . 
docker tag hyperjekyll greyhoundforty/hyperjekyll
docker push greyhoundforty/hyperjekyll
} 

redeploy() { 
oldcontainer=$(hyper fip ls | grep $IP | awk '{print $3}')
hyper fip detach "$oldcontainer"
hyper rm "$oldcontainer"
hyper pull greyhoundforty/hyperjekyll
hyper run -d --name=hyperjekyll -p 80:4000 greyhoundforty/hyperjekyll

}
