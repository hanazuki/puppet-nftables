define nftables::rule(
  Nftables::Family $family,
  String $table,
  String $chain,
  String $rule,
  String $order = '',
) {
  $order_base = "30 ${family} ${table} 30"

  concat::fragment { "nftables rule ${name}":
    target  => $::nftables::conf_path,
    content => "      ${rule}\n",
    order   => "${order_base} ${order}",
  }
}
