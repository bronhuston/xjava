#!/bin/bash

git clone https://github.com/exercism/x-api
cd x-api
git submodule init -- tracks/java
git submodule update

gem install bundler
bundle install
rackup&

sleep 5

curl 'localhost:9292/tracks/java/hello-world'
