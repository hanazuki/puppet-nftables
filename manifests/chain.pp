define nftables::chain(
  Nftables::Family $family,
  String $table,
  Optional[Nftables::Chaintype] $type,
  Optional[Nftables::Hook] $hook,
  Optional[String] $device,
  Optional[Integer] $priority,
  Variant[Hash, Array] $rules,
  Nftables::Policy $policy = accept,
) {
  $order_base = "30 ${family} ${table} 30 ${name}"

  concat::fragment {
    "nftables table ${family} ${table} chain ${name} begin_def":
      target  => $::nftables::conf_path,
      content => "    chain ${name} {\n",
      order   => "${order_base} 10",
      ;
    "nftables table ${family} ${table} chain ${name} end_def":
      target  => $::nftables::conf_path,
      content => "    }\n",
      order   => "${order_base} 90",
      ;
  }

  if ($type != undef) and ($hook != undef) and ($priority != undef) {
    if $device != undef {
      $_device = " device ${device}"
    }
    else {
      $_device = ''
    }

    concat::fragment { "nftables table ${family} ${table} chain ${name} type_decl":
      target  => $::nftables::conf_path,
      content => "      type ${type} hook ${hook}${_device} priority ${priority}; policy ${policy};\n\n",
      order   => "${order_base} 11",
    }
  }

  ::nftables::rules { "${family} ${table} ${name}":
    family => $family,
    table  => $table,
    chain  => $name,
    rules  => $rules,
  }
}
