#!/bin/bash

git clone https://github.com/exercism/x-api
cd x-api
git submodule init -- metadata
git submodule init -- tracks/java
git submodule update

gem install bundler
bundle install

RACK_ENV=development rackup&

sleep 5

export HOME=$HOME/build/bronhuston
export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin
go get -u github.com/exercism/cli/exercism
exercism -v

cd ~
pwd
mkdir -p workspace/exercism/exercises
cd ~/workspace/exercism/exercises
exercism configure --dir=~/workspace/exercism/exercises
exercism configure --api http://127.0.0.1:9292

curl -v 'localhost:9292/v2/exercises/java/bob'
exercism --verbose debug
exercism --verbose fetch java bob
tree java