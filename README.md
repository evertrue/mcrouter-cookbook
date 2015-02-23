# mcrouter
[![Build Status](https://travis-ci.org/evertrue/mcrouter-cookbook.svg)](https://travis-ci.org/evertrue/mcrouter-cookbook)
[![Coverage Status](https://coveralls.io/repos/evertrue/mcrouter-cookbook/badge.svg)](https://coveralls.io/r/evertrue/mcrouter-cookbook)

Install [mcrouter](https://github.com/facebook/mcrouter) and its dependencies, and provide mechanisms to configure and start mcrouter.

This cookbook can, optionally, install a copy of memcached to use locally. This can be disabled by setting `node['mcrouter']['local_memcached']` to false.

# Requirements

* `apt` cookbook
* `git` cookbook
* `memcached` cookbook

# Usage

* Include `mcrouter::default` in your node’s run list.

# Recipes

## default

Wraps it all up with a nice bow.

1. Set up & updates apt using `apt::default`
2. Install git using `git::default`
3. Include various recipes for this cookbook:
    * `mcrouter::install`
        - which includes `mcrouter::folloy`
    * `mcrouter::configure`

## install

Handle the installation of mcrouter & its dependencies.

## folly

Handle the installation of [`folly`](https://github.com/facebook/folly), a C++ lib Facebook developed.

## configure

Configure mcrouter.

## service

Set up, enable, and start services for mcrouter.

# Author

Author:: EverTrue, Inc. (<devops@evertrue.com>)
