name             'mcrouter'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          'apache2'
description      'Installs/Configures mcrouter'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '2.0.2'

supports 'ubuntu', '= 14.04'

depends 'apt'
depends 'build-essential'
depends 'ark'
depends 'memcached', '~> 1.7'
depends 'magic', '~> 1.1'
