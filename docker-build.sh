#!/bin/bash
#set -x

if [ $# -le 1 ]; then
    echo "missing parameters."
    exit 1
fi

dir=$(dirname $0)
sha=$($dir/manifest-alpine-sha.sh $@)       # $1 <source>/alpine:latest  amd64|arm|arm64
echo $sha
base_image="treehouses/alpine@$sha"
echo $base_image
arch=$2   # arm

if [ -n "$sha" ]; then
        tag=kaiyfan/webssh-tags:$arch
        #sed "s|{{base_image}}|$base_image|g" Dockerfile.template > /tmp/Dockerfile.$arch
        #sed "s|{{base_image}}|$base_image|g" Dockerfile.template > Dockerfile.$arch
        #cat /tmp/Dockerfile.$arch
        docker build -t $tag .
        #version=$(docker run -it $tag /bin/sh -c "nginx -v" |awk '{print$3}')
        #echo "$arch nginx version is $version"
        docker push $tag
fi