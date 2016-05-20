#!/bin/bash

sudo apt-get install tree -y

git clone https://github.com/exercism/x-api
cd x-api
git submodule init -- metadata
git submodule init -- tracks/java
git submodule update

gem install bundler
bundle install

RACK_ENV=development rackup&

sleep 5

export GOPATH=$HOME/build/bronhuston
export PATH=$PATH:$GOPATH/bin
go get -u github.com/exercism/cli/exercism
exercism -v

cd ~
mkdir -p workspace/exercism/exercises
cd ~/workspace/exercism/exercises
exercism configure --dir=~/workspace/exercism/exercises
exercism configure --api http://localhost:9292
exercism debug
exercism fetch java bob
tree java