# @summary OS dependent parameters
# @api private
class bird::params {
  case $facts['os']['family'] {
    'Debian': {
      $config_path_v4   = '/etc/bird/bird.conf'
      $config_path_v6   = '/etc/bird/bird6.conf'
      # Compatibility Debian oldoldstable
      # the bird package now provides bird and bird6 daemons
      if $facts['os']['name'] == 'debian' and $facts['os']['release']['major'] == '8' {
        $package_name_v6  = 'bird6'
      } else {
        $package_name_v6  = 'bird'
      }
    }
    'RedHat': {
      $config_path_v4   = '/etc/bird.conf'
      $config_path_v6   = '/etc/bird6.conf'
      $package_name_v6  = 'bird6'
    }
    'Archlinux': {
      $config_path_v4   = '/etc/bird.conf'
      $config_path_v6   = '/etc/bird.conf'
      $package_name_v6  = 'bird'
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  }
}
