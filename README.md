# puppet-bird

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
      enable_v6 => true,
  }
```

## Other class parameters
