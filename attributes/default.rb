default['mcrouter']['bin_path'] = '/usr/bin/mcrouter'
default['mcrouter']['user'] = 'mcrouter'

default['mcrouter']['local_memcached'] = true
default['memcached']['port'] = 11_811
default['memcached']['udp_port'] = 11_811

default['mcrouter']['cli_opts'] = {
  'port'        => 11_211,
  'config-file' => '/etc/mcrouter/mcrouter.json',
  'async-dir'   => '/var/spool/mcrouter',
  'log-path'    => '/var/log/mcrouter/mcrouter.log',
  'stats-root'  => '/var/mcrouter/stats',
}

default['mcrouter']['config'] = {
  'pools' => {
    'A' => {
      'servers' => [
        'localhost:11811',
      ],
    },
  },
  'route' => 'PoolRoute|A',
}
