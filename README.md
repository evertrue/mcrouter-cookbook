# mcrouter
[![Build Status](https://travis-ci.org/evertrue/mcrouter-cookbook.svg)](https://travis-ci.org/evertrue/mcrouter-cookbook)
[![Coverage Status](https://coveralls.io/repos/github/evertrue/mcrouter-cookbook/badge.svg?branch=master)](https://coveralls.io/github/evertrue/mcrouter-cookbook?branch=master)

Install [mcrouter](https://github.com/facebook/mcrouter) and its dependencies, and provide mechanisms to configure and start mcrouter.

This cookbook can, optionally, install a copy of memcached to use locally. This can be disabled by setting `node['mcrouter']['local_memcached']` to false.

# Requirements

* `apt` cookbook
* `ark` cookbook
* `memcached` cookbook
* `magic` cookbook

# Usage

* Include `mcrouter::default` in your node’s run list.

If you wish to customize any of the configuration for mcrouter, you will want to edit the two attributes used to populate the config file and the CLI arguments passed to `mcrouter` on service start:

* `node['mcrouter']['cli_opts']`
    - Do not overwrite this completely; the values specified already are required, instead, either:
        + supply updated values for these in addition to your new options
        + specify your particular CLI option: `default['mcrouter']['cli_opts']['async-dir']`
* `node['mcrouter']['config']`

# Recipes

## default

Wraps it all up with a nice bow.

1. Set up & update apt using `apt::default`
2. Install memcached using `memcached::default` if local memcached is enabled
3. Include recipes from this cookbook to build, install, configure, and start mcrouter:
    * `mcrouter::folly`
    * `mcrouter::install`
    * `mcrouter::configure`
    * `mcrouter::service`

## install

Handle the installation of mcrouter from source.

## folly

Handle the installation of [`folly`](https://github.com/facebook/folly), a C++ lib Facebook developed.

## configure

Configure mcrouter.

## service

Set up, enable, and start services for mcrouter.

# Author

Author:: EverTrue, Inc. (<devops@evertrue.com>)
