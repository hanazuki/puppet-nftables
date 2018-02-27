define nftables::table(
  Nftables::Family $family,
) {
  $order_base = "30 ${family} ${name}"

  concat::fragment {
    "nftables table ${family} ${name} header":
      target  => $::nftables::conf_path,
      content => "\n",
      order   => "${order_base} 00",
      ;

    "nftables table ${family} ${name} begin_def":
      target  => $::nftables::conf_path,
      content => "  table ${family} ${name} {\n",
      order   => "${order_base} 10",
      ;

    "nftables table ${family} ${name} end_def":
      target  => $::nftables::conf_path,
      content => "  }\n",
      order   => "${order_base} 90",
      ;
  }
}
