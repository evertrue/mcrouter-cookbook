name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'apache2'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'

supports 'ubuntu', '= 14.04'

depends 'apt'
depends 'git'
depends 'magic', '~> 1.0'
depends 'memcached', '~> 1.7'
depends 'magic', '~> 1.1'
