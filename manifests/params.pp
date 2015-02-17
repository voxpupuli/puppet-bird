# Class:: bird::params
#
class bird::params {
  case $::osfamily {
    'Debian': {
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $package_name_v4  = 'bird'
      $package_name_v6  = 'bird6'
    }
    'RedHat': {
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird'
      $package_name_v4  = 'bird'
      $package_name_v6  = 'bird'
    }    
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
