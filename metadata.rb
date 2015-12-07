name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'Apache-2.0'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '3.0.0'
chef_version     '>= 12.7' if respond_to?(:chef_version)
source_url       'https://github.com/evertrue/mcrouter-cookbook'
issues_url       'https://github.com/evertrue/mcrouter-cookbook/issues'

supports 'ubuntu', '= 16.04'
supports 'centos', '= 7.2'
supports 'centos', '= 7.3'

depends 'apt', '~> 6.1'
depends 'build-essential', '~> 8.0'
depends 'magic', '~> 1.5'
depends 'magic_shell', '1.0'
depends 'memcached', '~> 4.1'
depends 'systemd', '~> 3.1'
depends 'yum', '~> 5.0'
depends 'yum-epel', '~> 2.1'
