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
  case $::operatingsystem {
    /(Debian|Ubuntu)/: {
      $package_name_v4   = 'bird'
      $service_name_v4   = 'bird'
      $package_name_v6   = 'bird6'
      $service_name_v6   = 'bird6'
    }
    default: {
      fail("Unsupported operating system: ${::operatingsystem}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
