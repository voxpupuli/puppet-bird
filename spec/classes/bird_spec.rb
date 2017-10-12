require 'spec_helper'

describe 'bird', :type => :class do

  describe 'On an unknown operating system' do
    let(:facts) {{ :osfamily => 'Unknown' }}
    it { expect { catalogue }.to raise_error(Puppet::Error, %r{Unsupported osfamily}) }
  end

  context "On Debian" do
    let(:facts) {{ :osfamily => 'Debian' }}
    it { is_expected.to compile.with_all_deps }

    context "with only IPv4" do
      let(:params) {{
        config_file_v4: 'puppet:///modules/fooboozoo',
        enable_v6:      false,
        manage_conf: true,
        manage_service: true,
      }}
      it { is_expected.to contain_class("bird::params") }
      it { is_expected.to contain_package('bird') }
      it { is_expected.to contain_service('bird').with(
        'ensure'     => 'running',
        'hasstatus'  => 'false',
        'pattern'    => 'bird',
        'hasrestart' => 'false',
        'restart'    => '/usr/sbin/birdc configure'
      )}

      context "with service (v4) and rc disabled" do
        let(:params) {{
          config_file_v4:    'puppet:///modules/fooboozoo',
          service_v4_ensure: 'stopped',
          manage_service: true,
        }}
        it { is_expected.to contain_service('bird').with(
          'ensure'     => 'stopped',
          'enable'     => 'false',
          'hasstatus'  => 'false',
          'pattern'    => 'bird',
          'hasrestart' => 'false',
          'restart'    => '/usr/sbin/birdc configure'
        )}
      end

      it { is_expected.to contain_file('/etc/bird/bird.conf').with(
        'source' => 'puppet:///modules/fooboozoo',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      )}

      context "without configuration file (IPv4)" do
        let(:params) {{
          manage_conf: false,
        }}
        it { is_expected.not_to contain_file('/etc/bird/bird.conf') }
      end
    end

    context "with IPv4 and IPv6" do
      let(:params) {{
        config_file_v4: 'puppet:///modules/fooboozoo',
        enable_v6:       true,
        config_file_v6:  'puppet:///modules/fooboozoo6',
        manage_conf: true,
        manage_service: true,
      }}
      it { is_expected.to contain_class("bird::params") }
      it { is_expected.to contain_package('bird') }
      it { is_expected.to contain_service('bird').with(
        'ensure'     => 'running',
        'hasstatus'  => 'false',
        'pattern'    => 'bird',
        'hasrestart' => 'false',
        'restart'    => '/usr/sbin/birdc configure'
      )}

      context "with service (v6) and rc disabled" do
        let(:params) {{
          service_v6_enable: false,
          service_v4_enable: false,
          config_file_v4:    'puppet:///modules/fooboozoo',
          manage_service:   true,
          enable_v6:         true,
          config_file_v6:    'puppet:///modules/fooboozoo6',
          service_v6_ensure: 'stopped',
          service_v4_ensure: 'stopped',
        }}
        it { is_expected.to contain_service('bird').with(
          'ensure'     => 'stopped',
          'enable'     => 'false',
          'hasstatus'  => 'false',
          'pattern'    => 'bird',
          'hasrestart' => 'false',
          'restart'    => '/usr/sbin/birdc configure'
        )}
        it { is_expected.to contain_service('bird6').with(
          'ensure'     => 'stopped',
          'enable'     => 'false',
          'hasstatus'  => 'false',
          'pattern'    => 'bird6',
          'hasrestart' => 'false',
          'restart'    => '/usr/sbin/birdc6 configure'
        )}
      end

      it { is_expected.to contain_file('/etc/bird/bird.conf').with(
        'source' => 'puppet:///modules/fooboozoo',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[bird]'
      )}

      it { is_expected.to contain_package('bird6') }
      it { is_expected.to contain_service('bird6').with(
        'ensure'     => 'running',
        'hasstatus'  => 'false',
        'pattern'    => 'bird6',
        'hasrestart' => 'false',
        'restart'    => '/usr/sbin/birdc6 configure'
      )}

      it { is_expected.to contain_file('/etc/bird/bird6.conf').with(
        'source' => 'puppet:///modules/fooboozoo6',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
        'notify' => 'Service[bird6]'
      )}

      context "without configuration file (IPv4/IPv6)" do
        let(:params) {{
          enable_v6:   true,
          manage_conf: false
        }}

        it { is_expected.not_to contain_file('/etc/bird/bird.conf') }
        it { is_expected.not_to contain_file('/etc/bird/bird6.conf') }
      end
    end

  end
end
