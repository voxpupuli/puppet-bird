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
    it { should include_class("bird::params") }
    it { should contain_package('bird') }
  end

end
