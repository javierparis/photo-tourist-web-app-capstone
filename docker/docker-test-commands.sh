#!/bin/bash

/usr/local/bin/vnc.#!/bin/sh
set -x
rake db:create RAILS_ENV=test
rake db:migrate RAILS_ENV=test
#bundle exec rspec spec/models --fail-fast
bundle exec rspec spec/requests --fail-fast --format documentation --color
#bundle exec rspec spec/features --fail-fast
