# mcrouter
[![Build Status](https://travis-ci.org/evertrue/mcrouter-cookbook.svg)](https://travis-ci.org/evertrue/mcrouter-cookbook)

Install [mcrouter](https://github.com/facebook/mcrouter) and its dependencies, and provide mechanisms to configure and start mcrouter.

This cookbook can, optionally, install a copy of memcached to use locally. This can be disabled by setting `node['mcrouter']['local_memcached']` to false.

## Requirements

### Cookbooks

* `memcached` cookbook
* `magic` cookbook

### Platforms

The following platforms are supported and tested with Test Kitchen:

* Ubuntu 16.04
* Ubuntu 18.04

### Chef

* Chef 12.11+

## Usage

* Include `mcrouter::default` in your node’s run list.

If you wish to customize any of the configuration for mcrouter, you will want to edit the two attributes used to populate the config file and the CLI arguments passed to `mcrouter` on service start:

* ``node['mcrouter']['cli_opts']``
    - Do not overwrite this completely; the values specified already are required, instead, either:
        + supply updated values for these in addition to your new options
        + specify your particular CLI option: `default['mcrouter']['cli_opts']['async-dir']`
* ``node['mcrouter']['config']`` - See configuration options at [mcrouter wiki](https://github.com/facebook/mcrouter/wiki).

## Attributes

* `node['mcrouter']['user']` - User that mcrouter will run as

* `node['mcrouter']['local_memcached']` - Enable a local installation of memcache. `true` by default.
* `node['memcached']['port']` - Configure memcached port. This are overrides of [memcached cookbook](https://github.com/chef-cookbooks/memcached)
* `node['memcached']['udp_port']` - Configure memcached udp port. This are overrides of [memcached cookbook](https://github.com/chef-cookbooks/memcached)

* `node['mcrouter']['cli_opts']` - Collection of hashes that will be passed to `mcrouter` on start. You can see the whole list [here](https://github.com/facebook/mcrouter/wiki/Command-line-options)
* `node['mcrouter']['config']` - This will become mcrouter configuration file. You can read more at [Config Files on mcrouter wiki](https://github.com/facebook/mcrouter/wiki/Config-Files)

## Authors

Author:: EverTrue, Inc. <devops@evertrue.com>  
Author:: Jeff Byrnes <thejeffbyrnes@gmail.com>
