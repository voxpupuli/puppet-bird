# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.1.0](https://github.com/voxpupuli/puppet-bird/tree/v4.1.0) (2021-08-16)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- Implement a hash param to configure snippets via hiera [\#75](https://github.com/voxpupuli/puppet-bird/pull/75) ([bastelfreak](https://github.com/bastelfreak))
- Implement purging of unmanaged snippets [\#71](https://github.com/voxpupuli/puppet-bird/pull/71) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- cleanup syntax in init.pp [\#72](https://github.com/voxpupuli/puppet-bird/pull/72) ([bastelfreak](https://github.com/bastelfreak))

## [v4.0.0](https://github.com/voxpupuli/puppet-bird/tree/v4.0.0) (2021-07-19)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v3.1.1...v4.0.0)

**Breaking changes:**

- Drop Puppet 5 support [\#67](https://github.com/voxpupuli/puppet-bird/pull/67) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Ubuntu 16.04 support [\#66](https://github.com/voxpupuli/puppet-bird/pull/66) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL Debian 8 support [\#65](https://github.com/voxpupuli/puppet-bird/pull/65) ([bastelfreak](https://github.com/bastelfreak))
- Drop EoL CentOS 6 support [\#64](https://github.com/voxpupuli/puppet-bird/pull/64) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add snippet defined resource [\#62](https://github.com/voxpupuli/puppet-bird/pull/62) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- puppetlabs/stdlib: Allow 7.x [\#69](https://github.com/voxpupuli/puppet-bird/pull/69) ([bastelfreak](https://github.com/bastelfreak))
- reword README.md, update badges [\#68](https://github.com/voxpupuli/puppet-bird/pull/68) ([bastelfreak](https://github.com/bastelfreak))
- regenerate REFERENCE.md / Add puppet-lint-param-docs linter [\#59](https://github.com/voxpupuli/puppet-bird/pull/59) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.1](https://github.com/voxpupuli/puppet-bird/tree/v3.1.1) (2020-09-04)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v3.1.0...v3.1.1)

**Fixed bugs:**

- Use service status command to determine of bird is running [\#57](https://github.com/voxpupuli/puppet-bird/pull/57) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- modulesync 3.0.0 & puppet-lint updates [\#56](https://github.com/voxpupuli/puppet-bird/pull/56) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.0](https://github.com/voxpupuli/puppet-bird/tree/v3.1.0) (2020-07-09)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- Implement CentOS 6 support [\#54](https://github.com/voxpupuli/puppet-bird/pull/54) ([bastelfreak](https://github.com/bastelfreak))
- Validate Bird config before writing it [\#53](https://github.com/voxpupuli/puppet-bird/pull/53) ([bastelfreak](https://github.com/bastelfreak))
- Add Ubuntu 20 support [\#51](https://github.com/voxpupuli/puppet-bird/pull/51) ([bastelfreak](https://github.com/bastelfreak))
- Add support for Debian 10 and Ubuntu 18.04 [\#42](https://github.com/voxpupuli/puppet-bird/pull/42) ([dhoppe](https://github.com/dhoppe))

**Merged pull requests:**

- increase test coverage [\#52](https://github.com/voxpupuli/puppet-bird/pull/52) ([bastelfreak](https://github.com/bastelfreak))
- Add link to former maintainer to README.md [\#47](https://github.com/voxpupuli/puppet-bird/pull/47) ([bastelfreak](https://github.com/bastelfreak))
- Use voxpupuli-acceptance [\#46](https://github.com/voxpupuli/puppet-bird/pull/46) ([ekohl](https://github.com/ekohl))
- Remove unused nodesets + unify the acceptance tests [\#45](https://github.com/voxpupuli/puppet-bird/pull/45) ([ekohl](https://github.com/ekohl))
- update repo links to https [\#43](https://github.com/voxpupuli/puppet-bird/pull/43) ([bastelfreak](https://github.com/bastelfreak))

## [v3.0.0](https://github.com/voxpupuli/puppet-bird/tree/v3.0.0) (2019-12-05)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v2.0.0...v3.0.0)

**Breaking changes:**

- Drop Ubuntu 14.04, use more data types and drop UNSET defaults [\#32](https://github.com/voxpupuli/puppet-bird/pull/32) ([ekohl](https://github.com/ekohl))

**Implemented enhancements:**

- Implement config\_content parameter [\#36](https://github.com/voxpupuli/puppet-bird/pull/36) ([bastelfreak](https://github.com/bastelfreak))
- convert to data-in-modules [\#35](https://github.com/voxpupuli/puppet-bird/pull/35) ([bastelfreak](https://github.com/bastelfreak))
- Add Archlinux support and REFERENCE.md [\#34](https://github.com/voxpupuli/puppet-bird/pull/34) ([bastelfreak](https://github.com/bastelfreak))
- Add CentOS 7 support [\#33](https://github.com/voxpupuli/puppet-bird/pull/33) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- Remove duplicate CONTRIBUTING.md file [\#30](https://github.com/voxpupuli/puppet-bird/pull/30) ([dhoppe](https://github.com/dhoppe))
- Clean up acceptance spec helper [\#29](https://github.com/voxpupuli/puppet-bird/pull/29) ([ekohl](https://github.com/ekohl))

## [v2.0.0](https://github.com/voxpupuli/puppet-bird/tree/v2.0.0) (2019-03-14)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v1.2.1...v2.0.0)

**Breaking changes:**

- modulesync 2.6.0 & drop Puppet 4 [\#24](https://github.com/voxpupuli/puppet-bird/pull/24) ([bastelfreak](https://github.com/bastelfreak))

**Merged pull requests:**

- replace validate\_\* with datatypes [\#23](https://github.com/voxpupuli/puppet-bird/pull/23) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 2.1.0 and allow puppet 6.x [\#19](https://github.com/voxpupuli/puppet-bird/pull/19) ([bastelfreak](https://github.com/bastelfreak))

## [v1.2.1](https://github.com/voxpupuli/puppet-bird/tree/v1.2.1) (2018-09-07)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/v1.2.0...v1.2.1)

**Fixed bugs:**

- Fixes package name on Debian based os, add acceptance tests and update unit tests [\#10](https://github.com/voxpupuli/puppet-bird/pull/10) ([sbadia](https://github.com/sbadia))

**Merged pull requests:**

- allow puppetlabs/stdlib 5.x [\#16](https://github.com/voxpupuli/puppet-bird/pull/16) ([bastelfreak](https://github.com/bastelfreak))
- bump puppet version dependency to \>= 4.10.0 \< 6.0.0 [\#12](https://github.com/voxpupuli/puppet-bird/pull/12) ([bastelfreak](https://github.com/bastelfreak))
- Rely on beaker-hostgenerator for docker nodesets [\#11](https://github.com/voxpupuli/puppet-bird/pull/11) ([ekohl](https://github.com/ekohl))

## [v1.2.0](https://github.com/voxpupuli/puppet-bird/tree/v1.2.0) (2018-03-20)

[Full Changelog](https://github.com/voxpupuli/puppet-bird/compare/1.1.0...v1.2.0)

**Closed issues:**

- New forge release? [\#3](https://github.com/voxpupuli/puppet-bird/issues/3)

**Merged pull requests:**

- Migrate to Vox Pupuli [\#7](https://github.com/voxpupuli/puppet-bird/pull/7) ([bastelfreak](https://github.com/bastelfreak))

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


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
