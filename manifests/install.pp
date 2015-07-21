class collectd::install {
  case $::collectd::manage_install {
    true : {
      $package { $package_name:
        ensure   => $version,
        name     => $package_name,
        provider => $collectd::params::provider,
        before   => File['collectd.conf', 'collectd.d'],
      }
    }
    false : {
        notice ("Installation handled by user")
    }
    default: {
      fail("Value for collectd::manage_install not supported")
    }
  }
}
