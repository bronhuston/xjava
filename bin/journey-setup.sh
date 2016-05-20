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

export GOPATH=$HOME/build/bronhuston
export PATH=$PATH:$GOPATH/bin
go get -u github.com/exercism/cli/exercism
excercism -v