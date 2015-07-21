class collectd::install {
  case $::collectd::install_method() {
    'package' : {
      package { $collectd::package_name:
        ensure   => $version,
        name     => $package_name,
        provider => $collectd::params::provider,
        before   => File['collectd.conf', 'collectd.d'],
      }
    }
    'script_centos' : {
        notify ("installing via script")
        file {
        'install_collectd':
          ensure => 'file',
          source => $collectd::install_script_path,
          path   => '/usr/local/bin/install_collectd.sh',
          owner  => 'root',
          group  => 'root',
          mode   => '0744', # Use 0700 if it is sensitive
          notify => Exec['run_collectd_install'],
      }
      exec {
        'run_collectd_install':
         command     => '/usr/local/bin/install_collectd.sh',
         refreshonly => true,
         require     => Class['yum::repo::epel'],
      }
    }
    default: {
      fail("Value for collectd::manage_install not supported")
    }
  }
}
