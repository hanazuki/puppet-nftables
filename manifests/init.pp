class nftables(
  String $package_name,
  String $package_ensure,
  String $service_name,
  String $service_ensure,
  Boolean $service_enable,
  Stdlib::UnixPath $nft_path,
  Stdlib::UnixPath $conf_path,
  Array $tables,
) {
  contain ::nftables::install
  contain ::nftables::service
  contain ::nftables::ruleset

  Class['::nftables::install'] -> Class['::nftables::service']
  Class['::nftables::ruleset'] ~> Class['::nftables::service']
}
