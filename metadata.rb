name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'apache2'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

supports 'ubuntu', '= 14.04'

depends 'apt'
depends 'build-essential'
depends 'ark', '~> 0.9.0'
depends 'magic', '~> 1.0'
depends 'memcached', '~> 1.7'
depends 'magic', '~> 1.1'
