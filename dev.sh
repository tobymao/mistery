#!/bin/bash
RAILS_ENV=development unicorn -c config/unicorn.rb
