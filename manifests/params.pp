# Class:: bird::params
#
class bird::params {
  case $::osfamily {
    'Debian': {
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $config_path_v4   = '/etc/bird/bird.conf'
      $config_path_v6   = '/etc/bird/bird6.conf'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
