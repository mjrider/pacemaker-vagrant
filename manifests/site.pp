node /^node\d+/ {
  class{ 'apt':
    purge                => {
      'sources.list'     => true,
      'sources.list.d'   => true,
    }
  }

  include ::apt
  include ::apt::update

  apt::source { 'debian':
    location    => 'http://ftp.nl.debian.org/debian/',
    repos       => 'main contrib non-free',
    key         => {
      id        => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
      server    => 'pool.sks-keyservers.net'
    },
    include     => {
      src       => false
    }
  }
  apt::source { 'debian-security':
    location    => 'http://security.debian.org/',
    repos       => 'main contrib non-free',
    key         => {
      id        => 'A1BD8E9D78F7FE5C3E65D8AF8B48AD6246925553',
      server    => 'pool.sks-keyservers.net'
    },
    include     => {
      src       => false
    },
    release     => 'wheezy/updates'
  }

  apt::source { 'puppetlabs':
    location   => 'http://apt.puppetlabs.com',
    repos      => 'main',
    key         => {
      id        => '47B320EB4C7C375AA9DAE1A01054B7A24BD6EC30',
      server    => 'pool.sks-keyservers.net'
    },
    include     => {
      src       => false
    }
  }

  Class['apt::update'] -> Package<| |>

  class { 'corosync':
    enable_secauth    => true,
    threads           => 1,
    authkey           => 'io+ÂÉ´kJ6¸ègÜpáb&Ú|õ?Õb.§¹]»ÆJ/ç4]Æ¶üNçFñì¤ËKSô¥éÙêüru©¯ãùÎÙceÝ+Oäu´-_B?pg b×bãFM4²X\ÖºÀFÖ½
ø
,ò',
    authkey_source    => 'string',
    bind_address      => [ $ipaddress_eth1, $ipaddress_eth2 ],
    multicast_address => [ '239.1.1.2', '239.1.2.2' ],
    port              => [ 5405, 5415 ],
    rrp_mode          => 'active',
  }

  corosync::service { 'pacemaker':
    version => '0',
  }

  user { "vagrant":
    ensure => present,
    shell  => "/bin/bash",
  }

}
