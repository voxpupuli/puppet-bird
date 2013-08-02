# Module:: bird
# Manifest:: init.pp
#
# Author:: Sebastien Badia (<seb@sebian.fr>)
# Date:: 2013-08-02 17:52:35 +0200
# Maintainer:: Sebastien Badia (<seb@sebian.fr>)
#

import 'params.pp'

# Class:: bird
#
#
class bird (
  $package_name_v4 = $bird::params::package_name_v4,
  $service_name_v4 = $bird::params::service_name_v4,
  $enable_v6       = true,
  $package_name_v6 = $bird::params::package_name_v6,
  $service_name_v6 = $bird::params::service_name_v6,
) inherits bird::params {

  package {
    $package_name_v4:
      ensure => installed;
  }

  service {
    $service_name_v4:
      ensure      => running,
      enable      => true,
      hasrestart  => true,
      hasstatus   => false,
      pattern     => $service_name_v4,
      require     => Package[$package_name_v4];
  }

  if $enable_v6 {

    package {
      $package_name_v6:
        ensure => installed;
    }

    service {
      $service_name_v6:
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => false,
        pattern     => $service_name_v6,
        require     => Package[$package_name_v6];
    }
  } # enable_v6

} # Class:: bird
