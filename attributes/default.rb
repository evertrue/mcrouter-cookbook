default['mcrouter']['config'] = {
  'pools' => {
    'B' => {
      'servers' => [
        '10.0.111.182:11811',
        '10.0.111.155:11811'
      ],
      'protocol' => 'ascii',
      'keep-routing_prefix' => 'true'
    },
    'C' => {
      'servers' => [
        '10.0.112.176:11811',
        '10.0.112.15:11811'
      ],
      'protocol' => 'ascii',
      'keep-routing_prefix' => 'true'
    },
    'D' => {
      'servers' => [
        '10.0.113.230:11811'
      ],
      'protocol' => 'ascii',
      'keep-routing_prefix' => 'true'
    }
  },
  'named_handles' => [
    { 'type' => 'PoolRoute', 'name' => 'zoneB', 'pool' => 'B' },
    { 'type' => 'PoolRoute', 'name' => 'zoneC', 'pool' => 'C' },
    { 'type' => 'PoolRoute', 'name' => 'zoneD', 'pool' => 'D' }
  ],
  'routes' => [
    {
      'aliases' => ['/dc1/all/', '/dc1/ALL/', '/DC1/all', '/DC1/ALL'],
      'route' => {
        'type' => 'AllFastestRoute',
        'children' => %w(zoneB zoneC zoneD)
      }
    },
    {
      'aliases' => ['/dc1/b/', '/dc1/B/', '/DC1/b/', '/DC1/B/'],
      'route' => {
        'type' => 'AllFastestRoute',
        'children' => %w(zoneB zoneC zoneD)
      }
    },
    {
      'aliases' => ['/dc1/c/', '/dc1/C/', '/DC1/c/', '/DC1/C/'],
      'route' => {
        'type' => 'AllFastestRoute',
        'children' => %w(zoneC zoneD zoneB)
      }
    },
    {
      'aliases' => ['/dc1/d/', '/dc1/D/', '/DC1/d/', '/DC1/D/'],
      'route' => {
        'type' => 'AllFastestRoute',
        'children' => %w(zoneD zoneB zoneC)
      }
    }
  ]
}
