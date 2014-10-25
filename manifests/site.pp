node /^node\d+/ {
	class{ 'apt':
		purge_sources_list   => true,
		purge_sources_list_d   => true,
	}

	include apt

	class { 'apt::release':
		release_id => 'wheezy',
	}
	apt::source { 'debian':
		location          => 'http://ftp.nl.debian.org/debian/',
		repos             => 'main contrib non-free',
		key               => '46925553',
		key_server        => 'subkeys.pgp.net',
		include_src       => false,
	}

	apt::source { 'puppetlabs':
		location   => 'http://apt.puppetlabs.com',
		repos      => 'main',
		key        => '4BD6EC30',
		key_server => 'pgp.mit.edu',
		include_src       => false,
	}

	class { 'corosync':
		enable_secauth    => true,
		authkey => 'puppet:///modules/corosync/authkey',
		bind_address      => $ipaddress_eth1,
		multicast_address => '239.1.1.2',
		require => Class['apt'],
	}
	corosync::service { 'pacemaker':
		version => '0',
	}
}
