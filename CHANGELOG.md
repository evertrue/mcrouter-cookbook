# CHANGELOG for mcrouter

## [v3.0.0] (2017-08-15)

### Breaking changes:
* Removed support for Ubuntu 14.04
* Removed `node['folly']['version']`
* Added `node['mcrouter']['wangle_commit_hash']`, `node['mcrouter']['folly_commit_hash']` and `node['mcrouter']['double_conversion_commit_hash']` to indicate the required commit hash for each library.
* Switched to `systemd` for running `mcrouter` service.
* Tests need to be improved

### Changes:
* Added support for Ubuntu 16.04, CentOS 7.2 and CentOS 7.3

## [v2.0.2] (2015-12-15)

### Fixes:

* Delete only build subdirectory (so that ark does not run twice)

## [v2.0.1] (2015-12-07)

### Fixes:

* Updated test kitchen file format
* Re-order build/install ops so that build dirs are always deleted

## [v2.0.0] (2015-08-17)

### Breaking changes:

* Folly version updated to v0.53.0
    - This is now adjustable via an attribute, `node['folly']['version']`
* Mcrouter version set to v0.5.0
    - This is now adjustable via an attribute, `node['mcrouter']['version']`

### Fixes

* Packages needed for Folly/Mcrouter updated as per most recent Folly/Mcrouter docs

## [v1.0.1] (2015-07-15)

### Fixes:

* Add dependency package: libssl-dev

## [v1.0.0] (2015-07-09)

### Breaking changes:

* `['mcrouter']['src_dir']` no longer determines build location (that is now `:file_cache_path`), and as a result...
* Builds are now done in `:file_cache_path` instead of `/opt`
* `mcrouter::folly` is now included by `mcrouter::install`

### Changes:

* Vastly clean up the install process (e.g. now using `ark` for source install)
    - Stopped installing gtest
    - Pruned Apt package install list
    - Use `./configure` defaults rather than specifying a zillion environment variables
    - Just do `make install` for mcrouter and use the default install location (rather than linking `/usr/local/bin/mcrouter -> node['mcrouter']['install_dir']/bin/mcrouter`)
    - Just install `build-essentials` with the cookbook rather than devoting half the cookbook to setting up the build system
    - Break package installs out into `_deps` recipe
* Folly and McRouter now delete their build directories once they're finished installing
* Update the README
* Clean up the Upstart script a bit

### Fixes:

* Run `ldconfig` after `make install` on folly (addresses "library not found" issue with mcrouter)

## [v0.2.2] (2015-02-28)

### Fixes:

* Subscribed `service[mcrouter]` to its own service script to restart on any changes to its CLI options

## [v0.2.1] (2015-02-25)

### Fixes:

* Updated, clarified README

## [v0.2.0] (2015-02-25)

### Fixes:

* Replace missed hard-coded ownership settings with `node['mcrouter']['user']`

### Changes:

* Switch from hard-coded CLI flags to an hash attribute-driven system, utilizing the [`magic` cookbook](https://github.com/sczizzo/magic-cookbook)

## [v0.1.0] (2015-02-24)

### Fixes:

* Fix paths for dependent libraries for `mcrouter` build
* Ensure dirs needed for `mcrouter` exist
* Fix test assertion for `mcrouter` config

### Changes:

* Parameterize paths for folly & mcrouter
    - Makes for simpler configuration of builds
* Fix path to optionally-installed double-conversion lib
* Install & configure `memcached` to start on port 11811
    - `mcrouter` needs an instance of `memcached` somewhere to talk to; simplest thing is to just install it locally
* Set up an Upstart service to manage `mcrouter`

## [v0.0.1] (2015-02-19)

### Changes:

* Initial release:
    - Builds & installs mcrouter

[v0.2.1]: https://github.com/evertrue/mcrouter-cookbook/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/evertrue/mcrouter-cookbook/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/evertrue/mcrouter-cookbook/compare/v0.0.1...v0.1.0
[v0.0.1]: https://github.com/evertrue/mcrouter-cookbook/compare/da547ce9...v0.0.1
