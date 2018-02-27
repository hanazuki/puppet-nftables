class nftables::ruleset {
  concat { $::nftables::conf_path:
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0750',
  }

  concat::fragment { 'nftables shebang':
    target  => $::nftables::conf_path,
    content => "#!${::nftables::nft_path} -f\n",
    order   => '00',
  }

  if $::nftables::purge_unmanaged_ruleset {
    concat::fragment { 'nftables flush_ruleset':
      target  => $::nftables::conf_path,
      content => "flush ruleset\n",
      order   => '10',
    }
  }

  $::nftables::tables.each |$table_name, $table| {
    $chains = $table[chains]
    $_table = $table.delete(chains)
    ::nftables::table { $table_name: * => $_table }
    create_resources(::nftables::chain, $chains, {table => $table_name})
  }
}
