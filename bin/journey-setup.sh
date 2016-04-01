#!/bin/bash

rvm install 2.2.1
git clone https://github.com/exercism/x-api
cd x-api
git submodule init -- tracks/java
git submodule update

gem install bundler
bundle install
rackup
