# Puppet-bird

[![Build Status](https://github.com/voxpupuli/puppet-bird/workflows/CI/badge.svg)](https://github.com/voxpupuli/puppet-bird/actions?query=workflow%3ACI)
[![Release](https://github.com/voxpupuli/puppet-bird/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-bird/actions/workflows/release.yml)
[![Puppet Forge](https://img.shields.io/puppetforge/v/puppet/bird.svg)](https://forge.puppetlabs.com/puppet/bird)
[![Puppet Forge - downloads](https://img.shields.io/puppetforge/dt/puppet/bird.svg)](https://forge.puppetlabs.com/puppet/bird)
[![Puppet Forge - endorsement](https://img.shields.io/puppetforge/e/puppet/bird.svg)](https://forge.puppetlabs.com/puppet/bird)
[![Puppet Forge - scores](https://img.shields.io/puppetforge/f/puppet/bird.svg)](https://forge.puppetlabs.com/puppet/bird)
[![puppetmodule.info docs](http://www.puppetmodule.info/images/badge.png)](http://www.puppetmodule.info/m/puppet-bird)
[![GPL v3 License](https://img.shields.io/github/license/voxpupuli/puppet-bird.svg)](LICENSE)

Manage [bird](http://bird.network.cz/) routing daemon via Puppet

## Overview

The BIRD Internet Routing Daemon

The BIRD project aims to develop a fully functional dynamic IP routing daemon primarily targeted on (but not limited to) Linux, FreeBSD and other UNIX-like systems and distributed under the GNU General Public License.

Support: IPv4, IPv6, Multiple routing tables, BGP, RIP, OSPF, Static routes, IPv6 RA, Inter-table protocol

## Usage

A basic example fortwo config files, one for the ipv4 instance and one for the ipv6 instance of bird 1:

```puppet
class { 'bird':
  enable_v6       => true,
  config_file_v4  => 'puppet:///modules/bgp/ldn/bird.conf',
  config_file_v6  => 'puppet:///modules/bgp/ldn/bird6.conf',
}
```

You can also use the `bird::snippet` defined resource to manage parts of the
configuration. For example:

```puppet
bird::snippet {'AS1234':
  content => $content,
}
```

This will run the bird validation and reload it.

## Parameters

All parameters are documented in the [REFERENCE.md](./REFERENCE.md)

## Dependency

* `puppetlabs/stdlib`

# Contributors

* https://github.com/voxpupuli/puppet-bird/graphs/contributors

# Release Notes

See [CHANGELOG](https://github.com/voxpupuli/puppet-bird/blob/master/CHANGELOG.md) file.

## Contributions

Contribution is fairly easy:

* Fork the module into your namespace
* Create a new branch
* Commit your bugfix or enhancement
* Write a test for it (maybe start with the test first)
* Create a pull request

Detailed instructions are in the [CONTRIBUTING.md](.github/CONTRIBUTING.md)
file.

## License and Author

This module got migrated from [sbadia](https://github.com/sbadia) to Vox Pupuli.
It's licensed with [GPL version 3](LICENSE).
