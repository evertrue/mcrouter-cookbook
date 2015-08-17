default['mcrouter']['src_dir'] = '/opt/mcrouter'
default['mcrouter']['install_dir'] = "#{node['mcrouter']['src_dir']}/install"
default['mcrouter']['user'] = 'mcrouter'
default['mcrouter']['version'] = 'v0.5.0'

default['folly']['src_dir'] = '/opt/folly'
default['folly']['version'] = 'v0.53.0'

default['mcrouter']['local_memcached'] = true
set['memcached']['port'] = 11_811
set['memcached']['udp_port'] = 11_811

default['mcrouter']['cli_opts'] = {
  'port'        => 11_211,
  'config-file' => '/etc/mcrouter/mcrouter.json',
  'async-dir'   => '/var/spool/mcrouter',
  'log-path'    => '/var/log/mcrouter/mcrouter.log',
  'pid-file'    => '/var/run/mcrouter/mcrouter.pid',
  'stats-root'  => '/var/mcrouter/stats'
}

default['mcrouter']['config'] = {
  'pools' => {
    'A' => {
      'servers' => [
        'localhost:11811'
      ]
    }
  },
  'route' => 'PoolRoute|A'
}
