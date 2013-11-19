require 'spec_helper'

describe 'bird', :type => :class do

  describe 'On an unknown operating system' do
    let(:facts) {{ :osfamily => 'Unknown' }}
    it "should fail" do
      expect do
        subject
      end.to raise_error(Puppet::Error, /Unsupported osfamily/)
    end
  end

  context "On Debian" do
    let(:facts) {{ :osfamily => 'Debian' }}

    context "with only IPv4" do
      let(:params) {{
        :config_file_v4 => 'puppet:///modules/fooboozoo',
        :enable_v6      => false,
      }}
      it { should include_class("bird::params") }
      it { should contain_package('bird') }
      it { should contain_service('bird').with(
        :ensure     => 'running',
        :enable     => 'true',
        :hasstatus  => 'false',
        :pattern    => 'bird',
        :hasrestart => 'false',
        :restart    => '/usr/sbin/birdc configure'
      )}

      it { should contain_file('/etc/bird.conf').with(
        :source => 'puppet:///modules/fooboozoo',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0644',
        :notify => 'Service[bird]'
      )}

      context "without configuration file (IPv4)" do
        let(:params) {{
          :enable_v6    => false,
          :manage_conf  => false
        }}

        it { should_not contain_file('/etc/bird.conf') }
      end
    end

    context "with IPv4 and IPv6" do
      let(:params) {{
        :config_file_v4 => 'puppet:///modules/fooboozoo',
        :enable_v6      => true,
        :config_file_v6 => 'puppet:///modules/fooboozoo6',
      }}
      it { should include_class("bird::params") }
      it { should contain_package('bird') }
      it { should contain_service('bird').with(
        :ensure     => 'running',
        :enable     => 'true',
        :hasstatus  => 'false',
        :pattern    => 'bird',
        :hasrestart => 'false',
        :restart    => '/usr/sbin/birdc configure'
      )}

      it { should contain_file('/etc/bird.conf').with(
        :source => 'puppet:///modules/fooboozoo',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0644',
        :notify => 'Service[bird]'
      )}

      it { should contain_package('bird6') }
      it { should contain_service('bird6').with(
        :ensure     => 'running',
        :enable     => 'true',
        :hasstatus  => 'false',
        :pattern    => 'bird6',
        :hasrestart => 'false',
        :restart    => '/usr/sbin/birdc6 configure'
      )}

      it { should contain_file('/etc/bird6.conf').with(
        :source => 'puppet:///modules/fooboozoo6',
        :owner  => 'root',
        :group  => 'root',
        :mode   => '0644',
        :notify => 'Service[bird6]'
      )}

      context "without configuration file (IPv4/IPv6)" do
        let(:params) {{
          :enable_v6    => true,
          :manage_conf  => false
        }}

        it { should_not contain_file('/etc/bird.conf') }
        it { should_not contain_file('/etc/bird6.conf') }
      end
    end

    context "with only IPv4 but config. file unset" do
      let(:params) {{ :enable_v6 => false }}
      it "should fail" do
        expect {
          should include_class("bird::params")
        }.to raise_error(Puppet::Error, /must be set/)
      end
    end

    context "with IPv4 and IPVv6 but config. file unset" do
      let(:params) {{ :enable_v6 => true }}
      it "should fail" do
        expect {
          should include_class("bird::params")
        }.to raise_error(Puppet::Error, /must be set/)
      end
    end

  end
end
