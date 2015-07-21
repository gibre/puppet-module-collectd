class collectd::install {
  case $::collectd::install_method {
    'package' : {
      notice ("package installation")
      package { $collectd::package_name:
        ensure   => $collectd::version,
        name     => $collectd::package_name,
        provider => $collectd::params::provider,
      }
    }
    'script' : {
      notice ("installing via script")
      file {
      'install_collectd':
        ensure => 'file',
        source => $collectd::install_script_path,
        path   => '/usr/local/bin/install_collectd.sh',
        owner  => 'root',
        group  => 'root',
        mode   => '0744',
        notify => Exec['run_collectd_install'],
      } ->
      exec {
        'run_collectd_install':
         command     => '/usr/local/bin/install_collectd.sh',
         refreshonly => true,
      }
    }
    default: {
      fail("Value for collectd::manage_install not supported")
    }
  }
}
