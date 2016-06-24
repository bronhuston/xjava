#!/bin/bash

eval "$(curl -sL https://raw.githubusercontent.com/travis-ci/gimme/master/gimme | GIMME_GO_VERSION=1.5.3 bash)"

mkdir -p ~/workspace/exercism
cd ~/workspace/exercism/
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

mkdir -p ~/workspace/exercism/exercises
cd ~/workspace/exercism/exercises
exercism configure --dir=~/workspace/exercism/exercises
exercism configure --api http://localhost:9292

exercism debug
exercism fetch java bob
tree java

cp ~/workspace/exercism/xjava/exercises/bob/src/example/java/* ~/workspace/exercism/exercises/java/bob/src/main/java/
cd ~/workspace/exercism/exercises/java/bob/
gradle test