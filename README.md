# mcrouter
[![Build Status](https://travis-ci.org/evertrue/mcrouter-cookbook.svg)](https://travis-ci.org/evertrue/mcrouter-cookbook)
[![Coverage Status](https://coveralls.io/repos/evertrue/mcrouter-cookbook/badge.svg)](https://coveralls.io/r/evertrue/mcrouter-cookbook)

Install [mcrouter](https://github.com/facebook/mcrouter) and its dependencies, and provide mechanisms to configure and start mcrouter.

This cookbook can, optionally, install a copy of memcached to use locally. This can be disabled by setting `node['mcrouter']['local_memcached']` to false.

# Requirements

## Cookbooks

* `apt` cookbook
* `yum` cookbook
* `yum-epel` cookbook
* `memcached` cookbook
* `magic` cookbook
* `magic_shell` cookbook
* `systemd` cookbook

## Platforms

The following platforms are supported and tested with Test Kitchen:

* Ubuntu 16.04
* CentOS 7.2
* CentOS 7.3

## Chef

* Chef 12.7+

# Usage

* Include `mcrouter::default` in your node’s run list.

If you wish to customize any of the configuration for mcrouter, you will want to edit the two attributes used to populate the config file and the CLI arguments passed to `mcrouter` on service start:

* `node['mcrouter']['cli_opts']`
    - Do not overwrite this completely; the values specified already are required, instead, either:
        + supply updated values for these in addition to your new options
        + specify your particular CLI option: `set['mcrouter']['cli_opts']['async-dir']`
* `node['mcrouter']['config']` - See configuration options at [mcrouter wiki](https://github.com/facebook/mcrouter/wiki).

# Attributes
* node['mcrouter']['install_dir'] - Installation path of mcrouter
* node['mcrouter']['user'] - User that mcrouter will run as
* node['mcrouter']['version-branch'] - The latest release branch from [Mcrouter repo](https://github.com/facebook/mcrouter/branches/all).

* node['mcrouter']['double_conversion_commit_hash'] - Double conversion commit hash to be checked out from [double-conversion library](https://github.com/google/double-conversion). This is also hard coded in [mcrouter build scripts](https://github.com/facebook/mcrouter/blob/master/mcrouter/scripts/recipes/folly.sh#L26).
* node['mcrouter']['folly_commit_hash'] - Folly commit hash to be checkout out. This comes from mcrouter [release branch](https://github.com/facebook/mcrouter/commit/e907287079697baed001eedcac1194d7eeb86991)
* node['mcrouter']['wangle_commit_hash'] - Wangle commit hash to be checkout out. This comes from mcrouter [release branch](https://github.com/facebook/mcrouter/commit/e907287079697baed001eedcac1194d7eeb86991)

* node['mcrouter']['local_memcached'] - Enable a local installation of memcache. `true` by default.
* node['memcached']['port'] - Configure memcached port. This are overrides of [memcached cookbook](https://github.com/chef-cookbooks/memcached)
* node['memcached']['udp_port'] - Configure memcached udp port. This are overrides of [memcached cookbook](https://github.com/chef-cookbooks/memcached)

* node['mcrouter']['cli_opts'] - Collection of of hashes that will be passed to `mcrouter` on start. You can see the whole list [here](https://github.com/facebook/mcrouter/wiki/Command-line-options)
* node['mcrouter']['config'] - This will become mcrouter configuration file. You can read more at [Config Files on mcrouter wiki](https://github.com/facebook/mcrouter/wiki/Config-Files)

# Authors

Author:: EverTrue, Inc. (<devops@evertrue.com>)
