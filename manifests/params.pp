# Class:: bird::params
#
class bird::params {
  case $::osfamily {
    'Debian': {
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
