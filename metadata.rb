name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'Apache-2.0'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.2'
chef_version     '>= 12.6' if respond_to?(:chef_version)
source_url       'https://github.com/evertrue/mcrouter-cookbook'
issues_url       'https://github.com/evertrue/mcrouter-cookbook/issues'

supports 'ubuntu', '= 14.04'

depends 'apt'
depends 'build-essential'
depends 'ark'
depends 'memcached', '~> 1.7'
depends 'magic', '~> 1.1'
