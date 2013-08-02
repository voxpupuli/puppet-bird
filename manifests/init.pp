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
  $daemon_name_v4  = $bird::params::daemon_name_v4,
  $config_tmpl_v4  = 'UNSET',
  $enable_v6       = true,
  $daemon_name_v6  = $bird::params::daemon_name_v6,
  $config_tmpl_v6  = 'UNSET',
) inherits bird::params {

  package {
    $daemon_name_v4:
      ensure => installed;
  }

  service {
    $daemon_name_v4:
      ensure      => running,
      enable      => true,
      hasrestart  => true,
      hasstatus   => false,
      pattern     => $daemon_name_v4,
      require     => Package[$daemon_name_v4];
  }

  if $config_tmpl_v4 != 'UNSET' {
    file {
      '/etc/bird.conf':
        ensure  => file,
        content => template($config_tmpl_v4),
        owner   => root,
        group   => root,
        mode    => '0644',
        notify  => Service[$daemon_name_v4],
        require => Package[$daemon_name_v4];
    }
  } # config_tmpl_v4

  if $enable_v6 == true {

    package {
      $daemon_name_v6:
        ensure => installed;
    }

    service {
      $daemon_name_v6:
        ensure      => running,
        enable      => true,
        hasrestart  => true,
        hasstatus   => false,
        pattern     => $daemon_name_v6,
        require     => Package[$daemon_name_v6];
    }

    if $config_tmpl_v6 != 'UNSET' {
      file {
        '/etc/bird6.conf':
          ensure  => file,
          content => template($config_tmpl_v6),
          owner   => root,
          group   => root,
          mode    => '0644',
          notify  => Service[$daemon_name_v6],
          require => Package[$daemon_name_v6];
      }
    } # config_tmpl_v6
  } # enable_v6

} # Class:: bird
