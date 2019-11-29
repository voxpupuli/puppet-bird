# Class:: bird::params
#
class bird::params {
  case $facts['os']['family'] {
    'Debian': {
      $config_path_v4   = '/etc/bird/bird.conf'
      $config_path_v6   = '/etc/bird/bird6.conf'
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $package_name_v4  = 'bird'
      # Compatibility for Debian oldstable and Ubuntu old LTS
      # the bird package now provides bird and bird6 daemons
      if ($facts['os']['name'] == 'ubuntu' and $facts['os']['distro']['release'] in ['precise', 'trusty']) or
      ($facts['os']['name'] == 'debian' and $facts['os']['release']['major'] in ['7', '8']) {
        $package_name_v6  = 'bird6'
      } else {
        $package_name_v6  = 'bird'
      }
    }
    'RedHat': {
      $config_path_v4   = '/etc/bird.conf'
      $config_path_v6   = '/etc/bird6.conf'
      $daemon_name_v4   = 'bird'
      $daemon_name_v6   = 'bird6'
      $package_name_v4  = 'bird'
      $package_name_v6  = 'bird6'
    }
    default: {
      fail("Unsupported osfamily: ${facts['os']['family']}")
    }
  } # Case $::operatingsystem
} # Class:: bird::params
