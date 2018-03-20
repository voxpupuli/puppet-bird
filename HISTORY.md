## [1.1.0](https://github.com/voxpupuli/puppet-bird/tree/1.1.0) (2017-10-13)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/1.0.0...1.1.0)

* spec: Rubocop all the things !!!
* spec: Update spec to rspec3 and new matcher
* metadata: Update supported versions, and close deps.
* modulesync 1.2.1
* init: Added missing config_path as class parameter (for hiera)
* travis: Disable ruby 1.9 testing
* Fix default RedHat config paths
* Added conditional for RedHat based distributions, and added $package_name_v* for removing dupl
* Conservative defaults
* Per-OS config path, and fix path on Debian
* Add support for config templates
* msync: remove 2.7 series, add puppet 4.x lint and blacksmith
* spec: Fix un-supported rspec keyword
* metadata: Fix SPDX licence id
* rakefile: Fix configuration.fail_on_warnings boolean
* Update using modulesync (update rspec configs)
* Update using modulesync (fix rakefile and bundle cmd)
* Update using modulesync
* spec: include_class is deprecated, let switch to contain_class
* lint: Lint all parameter documentation
* qa: Remove deprectated import
* gemfile: Remove specific pin on 2.14.x rspec

## 2014-08-25 - 1.0.0
* Switch to metadata.json (puppetforge)
* Fix spec tests and update readme
* Use semver.org

## 2013-11-19 - 0.0.5
* Add param to completly disable service managment (for LDN (bird in netns))

## 2013-11-19 - 0.0.4
* Add extra params
* And dependency to stdlib (params checks)

## 2013-11-17 - 0.0.3
* Add `manage_conf` parameter (disable bird configurations (for http://ldn-fai.net/))

## 2013-10-27 - 0.0.2
* Update params, use source instead of content
* Add spec/travis tests
* Use birdc configure (soft) instead of service restart

## 2013-08-02 - 0.0.1
* Initial work in progress
