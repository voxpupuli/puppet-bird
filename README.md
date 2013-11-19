# Puppet-bird [![Build Status](https://travis-ci.org/sbadia/puppet-bird.png)](https://travis-ci.org/sbadia/puppet-bird)

Manage [bird](http://bird.network.cz/) routing daemon via Puppet

## Overview

The BIRD Internet Routing Daemon

The BIRD project aims to develop a fully functional dynamic IP routing daemon primarily targeted on (but not limited to) Linux, FreeBSD and other UNIX-like systems and distributed under the GNU General Public License. 

Support: IPv4, IPv6, Multiple routing tables, BGP, RIP, OSPF, Static routes, IPv6 RA, Inter-table protocol

## Usage

```puppet
class { 'bird':
  enable_v6       => true,
  config_file_v4  => 'puppet:///modules/bgp/ldn/bird.conf',
  config_file_v6  => 'puppet:///modules/bgp/ldn/bird6.conf',
}
```

## Parameters

* `enable_v6`: Boolean, enable or disable IPv6 (install bird6 package).
* `manage_conf`: Boolean, enable or disable bird configuration setup.
* `config_file_v4`: Location of IPv4 bird configuration.
* `service_v4_ensure`: State of IPv4 service (running/stopped).
* `service_v4_enable`: Boolean, run Bird V4 on boot.
* `config_file_v6`: Location of IPv6 bird configuration.
* `service_v6_ensure`: State of IPv6 service (running/stopped).
* `service_v6_enable`: Boolean, run Bird V6 on boot.

## Dependency

* `puppetlabs/stdlib`

## Development

[Feel free to contribute](https://github.com/sbadia/puppet-metche/). I'm not a big fan of centralized services like GitHub but I used it to permit easy pull-requests, so show me that's a good idea!
