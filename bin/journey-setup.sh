#!/bin/bash

git clone https://github.com/exercism/x-api
cd x-api
git submodule init -- tracks/java
git submodule update

gem install bundler
bundle install
rackup --host 127.0.0.1&

ps aux | grep rackup

curl '127.0.0.1:9292/tracks/java/hello-world'
