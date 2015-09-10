# Class:: bird::params
#
class bird::params {
  case $::osfamily {
    'Debian': {
      $config_path_v4   = '/etc/bird/bird.conf'
      $config_path_v6   = '/etc/bird/bird6.conf'
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $package_name_v4  = 'bird'
      $package_name_v6  = 'bird6'
    }
    'RedHat': {
      $config_path_v4   = '/etc/bird/bird.conf'
      $config_path_v6   = '/etc/bird/bird6.conf'
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $package_name_v4  = 'bird'
      $package_name_v6  = 'bird6'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
