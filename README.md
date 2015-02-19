# mcrouter
[![Build Status](https://travis-ci.org/evertrue/mcrouter-cookbook.svg)](https://travis-ci.org/evertrue/mcrouter-cookbook)
[![Coverage Status](https://coveralls.io/repos/evertrue/mcrouter-cookbook/badge.svg)](https://coveralls.io/r/evertrue/mcrouter-cookbook)

Install [mcrouter](https://github.com/facebook/mcrouter) and its dependencies, and provide mechanisms to configure and start mcrouter.

# Requirements

* `apt` cookbook
* `git` cookbook

# Usage

* Include `mcrouter::default` in your node’s run list.

# Recipes

## default

1. Sets up & updates apt
2. Installs git
3. Installs the necessary dependencies for mcrouter:
    * various packages, including gcc & g++
    * [`folly`](https://github.com/facebook/folly), a C++ lib Facebook developed
4. Installs `mcrouter`, and symlinks it to to `/usr/local/bin`

# Author

Author:: EverTrue, Inc. (<devops@evertrue.com>)
