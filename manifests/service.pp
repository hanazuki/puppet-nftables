class nftables::service {
  service { $::nftables::service_name:
    ensure => $::nftables::service_ensure,
    enable => $::nftables::service_enable,
  }
}
