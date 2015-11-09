#!/bin/bash
set -e

echo Building on $TRAVIS_OS_NAME

if [[ $TRAVIS_OS_NAME = "linux" ]]
then
    echo Building in CentOS 5 Docker container
    # run CentOS5 based docker container
    docker run -e TRAVIS_BRANCH -e TRAVIS_PULL_REQUEST -e ANACONDA_TOKEN -v `pwd`:/bioconda-recipes bioconda/bioconda-builder
else
    echo Building on Mac OS X
    export PATH=/anaconda/bin:$PATH
    # build packages
    scripts/build-packages.py --repository . --packages `cat osx-whitelist.txt`
fi
