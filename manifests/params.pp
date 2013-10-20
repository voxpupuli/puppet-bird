# Module:: bird
# Manifest:: params.pp
#
# Author:: Sebastien Badia (<seb@sebian.fr>)
# Date:: 2013-08-02 18:04:09 +0200
# Maintainer:: Sebastien Badia (<seb@sebian.fr>)
#

# Class:: bird::params
#
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
