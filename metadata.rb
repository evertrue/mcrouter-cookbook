name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'Apache-2.0'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.1'
chef_version     '>= 12.7' if respond_to?(:chef_version)
source_url       'https://github.com/evertrue/mcrouter-cookbook'
issues_url       'https://github.com/evertrue/mcrouter-cookbook/issues'

supports 'ubuntu', '= 16.04'

depends 'build-essential'
depends 'magic', '~> 1.5'
depends 'memcached', '~> 5.1'
