class collectd::install {
  $package { $package_name:
    ensure   => $version,
    name     => $package_name,
    provider => $collectd::params::provider,
    before   => File['collectd.conf', 'collectd.d'],
  }
}
