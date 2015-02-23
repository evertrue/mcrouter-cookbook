default['mcrouter']['src_dir'] = '/opt/mcrouter'
default['mcrouter']['install_dir'] = "#{node['mcrouter']['src_dir']}/install"
default['mcrouter']['user'] = 'mcrouter'

default['folly']['src_dir'] = '/opt/folly'

default['mcrouter']['local_memcached'] = true
set['memcached']['port'] = 11_811
set['memcached']['udp_port'] = 11_811

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
