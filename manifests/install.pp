class nftables::install {
  package { $::nftables::package_name:
    ensure => $::nftables::package_ensure,
  }
}
