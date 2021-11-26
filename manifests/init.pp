# @summary Install and configure bird
# @author Sebastien Badia <http://sebastien.badia.fr/>
# @author Lorraine Data Network <http://ldn-fai.net/>
#
# @param config_file_v4
#   Bird configuration file for IPv4.
#
# @param config_template_v4
#   Bird configuration template for IPv4. This value is a template source, it
#   will be passed into the template() function.
#
# @param config_epp_v4
#   Bird configuration template for IPv4. This value is an epp source, it
#   will be passed into the epp() function.
#
# @param config_epp_v4_data
#   Bird configuration template data for IPv4. This value is an epp data source
#   will be passed into the epp() function.
#
# @param daemon_name_v6
#   The service name used by puppet resource
#
# @param package_name_v6
#   The package name used by puppet resource
#
# @param daemon_name_v4
#   The service name used by puppet resource
#
# @param package_name_v4
#   The package name used by puppet resource
#
# @param config_path_v6
#   The full path of the v6 configuration file
#
# @param config_path_v4
#   The full path of the v4 configuration file
#
# @param enable_v6
#   Boolean for enable IPv6 (install bird6 package). Defaults to false and it's only required if you use a legacy distribution that ships bird + bird6. Newer releases have native IPv6 support.
#
# @param manage_conf
#   Boolean, global parameter to disable or enable mangagment of bird configuration files.
#
# @param manage_service
#   Boolean, global parameter to disable or enable mangagment of bird service.
#
# @param service_v6_ensure
#   Bird IPv6 daemon ensure (shoud be running or stopped).
#
# @param service_v6_enable
#   Boolean, enabled param of Bird IPv6 service (run at boot time).
#
# @param service_v4_ensure
#   Bird IPv4 daemon ensure (shoud be running or stopped).
#
# @param service_v4_enable
#   Boolean, enabled param of Bird IPv4 service (run at boot time).
#
# @param config_file_v6
#  Bird configuration file for IPv6.
#
# @param config_template_v6
#   Bird configuration template for IPv6. This value is a template source, it
#   will be passed into the template() function.
#
# @param config_epp_v6
#   Bird configuration template for IPv6. This value is a epp source, it
#   will be passed into the epp() function.
#
# @param config_epp_v6_data
#   Bird configuration template data for IPv4. This value is an epp data source
#   will be passed into the epp() function.
#
# @param manage_repo
#   Add the upstream repository from CZ.NIC. This is currently only supported for CentOS 7
#
# @param config_content_v4
#   A string that will be used for the bird config file
#
# @param config_content_v6
#   A string that will be used for the bird6 config file
#
# @param v4_path
#   Path to the bird binary
#
# @param v6_path
#   Optional path to the bird6 binary. Only set on legacy operating systems that run bird1
#
# @param purge_unmanaged_snippets
#   The module won't purge unmanaged snippets by default. By enabling this, Puppet will purge all of them except the ones created with bird::snippet()
#
# @param snippets
#   Hash of resources for bird::snippet()
#
# @example IPv4 only
#   class { 'bird':
#     config_file_v4 => 'puppet:///modules/bgp/ldn/bird.conf',
#   }
#
# @example Both IPv4 and IPv6
#   class { 'bird':
#     enable_v6      => true,
#     config_file_v4 => 'puppet:///modules/bgp/ldn/bird.conf',
#     config_file_v6 => 'puppet:///modules/bgp/ldn/bird6.conf',
#   }
#
class bird (
  Stdlib::Absolutepath $config_path_v4,
  String[1] $package_name_v6,
  Stdlib::Absolutepath $config_path_v6,
  Stdlib::Absolutepath $v4_path,
  Optional[Stdlib::Absolutepath] $v6_path,
  Boolean $enable_v6,
  String[1] $daemon_name_v4                     = 'bird',
  String[1] $package_name_v4                    = 'bird',
  Optional[Stdlib::Filesource] $config_file_v4  = undef,
  Optional[String[1]] $config_template_v4       = undef,
  Optional[String[1]] $config_epp_v4            = undef,
  Hash[String[1], Any] $config_epp_v4_data      = {},
  Boolean $manage_conf                          = false,
  Boolean $manage_service                       = false,
  Stdlib::Ensure::Service $service_v6_ensure    = 'running',
  Boolean $service_v6_enable                    = false,
  Stdlib::Ensure::Service $service_v4_ensure    = 'running',
  Boolean $service_v4_enable                    = false,
  String[1] $daemon_name_v6                     = 'bird6',
  Optional[Stdlib::Filesource] $config_file_v6  = undef,
  Optional[String[1]] $config_template_v6       = undef,
  Optional[String[1]] $config_epp_v6            = undef,
  Hash[String[1], Any] $config_epp_v6_data      = {},
  Boolean $manage_repo                          = false,
  Optional[String[1]] $config_content_v4        = undef,
  Optional[String[1]] $config_content_v6        = undef,
  Boolean $purge_unmanaged_snippets             = false,
  Hash[String[1], Hash] $snippets               = {},
) {
  if $purge_unmanaged_snippets {
    $snippet_hash = { 'recurse' => true, 'purge' => true }
  } else {
    $snippet_hash = {}
  }
  if $manage_repo {
    yumrepo { 'bird':
      baseurl  => 'ftp://bird.network.cz/pub/bird/centos/7/x86_64/',
      descr    => 'Official bird packages from CZ.NIC',
      enabled  => 1,
      gpgcheck => 1,
      gpgkey   => 'ftp://bird.network.cz/pub/bird/centos/7/x86_64/RPM-GPG-KEY-network.cz',
    }
    Yumrepo['bird'] -> Package <| name == $package_name_v4 or name == $package_name_v6 |>
  }

  ensure_packages([$package_name_v4], { 'ensure' => 'present' })

  if $manage_service {
    service { $daemon_name_v4:
      ensure     => $service_v4_ensure,
      enable     => $service_v4_enable,
      hasrestart => false,
      restart    => '/usr/sbin/birdc configure',
      pattern    => $daemon_name_v4,
      require    => Package[$package_name_v4],
    }
  }

  if $manage_conf {
    $path_params_v4 = [$config_file_v4, $config_template_v4, $config_content_v4, $config_epp_v4]
    $path_count_v4 = $path_params_v4.reduce(0)|$value, $item| { $item ? { undef => $value, default => $value + 1 } }
    if $path_count_v4 > 1 {
      fail("either config_file_v4 or config_template_v4 or config_epp_v4 or config_content_v4 parameter must be set (config_file_v4: ${config_file_v4}, config_template_v4: ${config_template_v4}, config_epp_v4: ${config_epp_v4}, config_content_v4: ${config_content_v4})")
    }

    if $config_file_v4 {
      $config_file_v4_content = undef
    } elsif $config_content_v4 {
      $config_file_v4_content = $config_content_v4
    } elsif $config_template_v4 {
      $config_file_v4_content = template($config_template_v4)
    } else {
      $config_file_v4_content = epp($config_epp_v4, $config_epp_v4_data)
    }

    file { $config_path_v4:
      ensure       => file,
      source       => $config_file_v4,
      content      => $config_file_v4_content,
      owner        => root,
      group        => root,
      mode         => '0644',
      validate_cmd => "${v4_path} -p -c %",
      require      => Package[$package_name_v4],
    }

    # people might want to throw config snippets into the filesystem and include them in the main config
    # we make this easier with the bird::snippet() defined resource. We create the directory for that here
    $additional_config_path_v4 = "${dirname($config_path_v4)}/snippets"
    if $manage_service {
      File[$config_path_v4] ~> Service[$daemon_name_v4]
      File[$additional_config_path_v4] ~> Service[$daemon_name_v4]
    }
    unless defined(File[$additional_config_path_v4]) {
      file { $additional_config_path_v4:
        ensure  => 'directory',
        owner   => 'root',
        group   => 'root',
        require => Package[$package_name_v4],
        *       => $snippet_hash,
      }
    }
  }

  if $enable_v6 {
    if $facts['os']['name'] == 'Archlinux' {
      fail('The bird version in Archlinux does not provide a seperate daemon for IPv6. You cannot explicitly enable it. The default daemon already has IPv6 support')
    }

    ensure_packages([$package_name_v6], { 'ensure' => 'present' })

    if $manage_service {
      service { $daemon_name_v6:
        ensure     => $service_v6_ensure,
        enable     => $service_v6_enable,
        hasrestart => false,
        restart    => '/usr/sbin/birdc6 configure',
        hasstatus  => false,
        pattern    => $daemon_name_v6,
        require    => Package[$package_name_v6],
      }
    }

    if $manage_conf {
      $path_params_v6 = [$config_file_v6, $config_template_v6, $config_content_v6, $config_epp_v6]
      $path_count_v6 = $path_params_v6.reduce(0)|$value, $item| { $item ? { undef => $value, default => $value + 1 } }
      if $path_count_v6 > 1 {
        fail("either config_file_v6 or config_template_v6 or config_epp_v6 or config_content_v6 parameter must be set (config_file_v6: ${config_file_v6}, config_template_v6: ${config_template_v6}), config_epp_v6: ${config_epp_v6}), config_content_v6: ${config_content_v6}")
      }

      if $config_file_v6 {
        $config_file_v6_content = undef
      } elsif $config_content_v6 {
        $config_file_v6_content = $config_content_v6
      } elsif $config_file_v6_content {
        $config_file_v6_content = template($config_template_v6)
      } else {
        $config_file_v6_content = epp($config_epp_v6, $config_epp_v6_data)
      }

      assert_type(Stdlib::Absolutepath, $v6_path)
      file { $config_path_v6:
        ensure       => file,
        source       => $config_file_v6,
        content      => $config_file_v6_content,
        owner        => root,
        group        => root,
        mode         => '0644',
        validate_cmd => "${v6_path} -p -c %",
        require      => Package[$package_name_v6],
      }

      # people might want to throw config snippets into the filesystem and include them in the main config
      # we make this easier with the bird::snippet() defined resource. We create the directory for that here
      $additional_config_path_v6 = "${dirname($config_path_v6)}/snippets"
      if $manage_service {
        File[$config_path_v6] ~> Service[$daemon_name_v6]
        File[$additional_config_path_v6] ~> Service[$daemon_name_v6]
      }
      unless defined(File[$additional_config_path_v6]) {
        file { $additional_config_path_v6:
          ensure  => 'directory',
          owner   => 'root',
          group   => 'root',
          require => Package[$package_name_v6],
          *       => $snippet_hash,
        }
      }
    }
  }

  $snippets.each |String[1] $snippet_title, Hash $snippet_params| {
    bird::snippet { $snippet_title:
      * => $snippet_params,
    }
  }
}
