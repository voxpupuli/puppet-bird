# Puppet-bird [![Build Status](https://travis-ci.org/sbadia/puppet-bird.png)](https://travis-ci.org/sbadia/puppet-bird)

Manage [bird](http://bird.network.cz/) routing daemon via Puppet

## Usage

### Using default values
```
include 'bird'
```

### Overide values
```
  class {
    'bird':
      enable_v6       => true,
      config_tmpl_v4  => 'arnldn/bird/bird.conf.erb',
      config_tmpl_v6  => 'arnldn/bird/bird6.conf.erb',
  }
```
