define nftables::rules(
  Nftables::Family $family,
  String $table,
  String $chain,
  Variant[Hash, Array] $rules,
  String $order = '',
) {
  $rules.each |$idx, $rule| {
    if $idx =~ Integer {
      $_order = "${order} ${sprintf('%04d', $idx)}"
    }
    else {
      $_order = "${order} ${idx}"
    }

    if $rule =~ String {
      ::nftables::rule { "${family} ${table} ${chain} ${rule.md5}":
        family => $family,
        table  => $table,
        chain  => $chain,
        rule   => $rule,
        order  => $_order,
      }
    }
    else {
      ::nftables::rules { "${family} ${table} ${chain} ${_order}":
        family => $family,
        table  => $table,
        chain  => $chain,
        rule   => $rule,
        order  => $_order,
      }
    }
  }
}
