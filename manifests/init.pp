# == Class: bird
#
# Install and configure bird
#
# === Parameters
#
# [*config_file_v4*]
#  Bird configuration file for IPv4.
#  Default: UNSET. (this value is a puppet source, example 'puppet:///modules/bgp/bird.conf').
#
# [*enable_v6*]
#   Boolean for enable IPv6 (install bird6 package)
#   Default: true
#
# [*manage_conf*]
#   Boolean, global parameter to disable or enable mangagment of bird configuration files.
#   Default: true
#
# [*service_v6_ensure*]
#   Bird IPv6 daemon ensure (shoud be running or stopped).
#   Default: running
#
# [*service_v6_enable*]
#   Boolean, enabled param of Bird IPv6 service (run at boot time).
#   Default: true
#
# [*service_v4_ensure*]
#   Bird IPv4 daemon ensure (shoud be running or stopped).
#   Default: running
#
# [*service_v4_enable*]
#   Boolean, enabled param of Bird IPv4 service (run at boot time).
#   Default: true
#
# [*config_file_v6*]
#  Bird configuration file for IPv6.
#  Default: UNSET. (this value is a puppet source, example 'puppet:///modules/bgp/bird6.conf').
#
# === Examples
#
#  class { 'bird':
#    enable_v6       => true,
#    config_file_v4  => 'puppet:///modules/bgp/ldn/bird.conf',
#    config_file_v6  => 'puppet:///modules/bgp/ldn/bird6.conf',
#  }
#
# === Authors
#
# Sebastien Badia <http://sebastien.badia.fr/>
# Lorraine Data Network <http://ldn-fai.net/>
#
# === Copyright
#
# Copyleft 2013 Sebastien Badia
# See LICENSE file
#
class bird (
  $daemon_name_v4     = $bird::params::daemon_name_v4,
  $config_file_v4     = 'UNSET',
  $enable_v6          = true,
  $manage_conf        = true,
  $manage_service     = true,
  $service_v6_ensure  = 'running',
  $service_v6_enable  = true,
  $service_v4_ensure  = 'running',
  $service_v4_enable  = true,
  $daemon_name_v6     = $bird::params::daemon_name_v6,
  $config_file_v6     = 'UNSET',
) inherits bird::params {

  validate_bool($manage_conf)
  validate_bool($manage_service)

  validate_bool($enable_v6)
  validate_bool($service_v6_enable)
  validate_bool($service_v4_enable)

  validate_re($service_v6_ensure,['^running','^stopped'])
  validate_re($service_v4_ensure,['^running','^stopped'])

  package {
    $daemon_name_v4:
      ensure => installed;
  }

  if $manage_service == true {
    service {
      $daemon_name_v4:
        ensure      => $service_v4_ensure,
        enable      => $service_v4_enable,
        hasrestart  => false,
        restart     => '/usr/sbin/birdc configure',
        hasstatus   => false,
        pattern     => $daemon_name_v4,
        require     => Package[$daemon_name_v4];
    }
  }

  if $manage_conf == true {
    if $config_file_v4 == 'UNSET' {
      fail("config_file_v4 parameter must be set (value: ${config_file_v4})")
    } else {
      file {
        '/etc/bird.conf':
          ensure  => file,
          source  => $config_file_v4,
          owner   => root,
          group   => root,
          mode    => '0644',
          notify  => Service[$daemon_name_v4],
          require => Package[$daemon_name_v4];
      }
    } # config_tmpl_v4
  } # manage_conf

  if $enable_v6 == true {

    package {
      $daemon_name_v6:
        ensure => installed;
    }

    if $manage_service == true {
      service {
        $daemon_name_v6:
          ensure     => $service_v6_ensure,
          enable     => $service_v6_enable,
          hasrestart => false,
          restart    => '/usr/sbin/birdc6 configure',
          hasstatus  => false,
          pattern    => $daemon_name_v6,
          require    => Package[$daemon_name_v6];
      }
    }

    if $manage_conf == true {
      if $config_file_v6 == 'UNSET' {
        fail("config_file_v6 parameter must be set (value: ${config_file_v6})")
      } else {
        file {
          '/etc/bird6.conf':
            ensure  => file,
            source  => $config_file_v6,
            owner   => root,
            group   => root,
            mode    => '0644',
            notify  => Service[$daemon_name_v6],
            require => Package[$daemon_name_v6];
        }
      } # config_tmpl_v6
    } # manage_conf
  } # enable_v6

} # Class:: bird
