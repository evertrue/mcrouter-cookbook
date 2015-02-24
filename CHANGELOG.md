# CHANGELOG for mcrouter

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

[v0.1.0]: https://github.com/evertrue/mcrouter-cookbook/compare/v0.0.1...v0.1.0
[v0.0.1]: https://github.com/evertrue/mcrouter-cookbook/compare/da547ce9...v0.0.1
