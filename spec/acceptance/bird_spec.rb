# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'bird class' do
  let(:pp) do
    # The RedHat package only provides an example configuration for IPv4
    # Therefore we can't start the daemon for IPv6
    <<-PUPPET
      class { 'bird':
        manage_service    => true,
        service_v4_enable => true,
        enable_v6         => $facts['os']['family'] != 'Archlinux',
        service_v6_enable => true,
        service_v6_ensure => bool2str($facts['os']['family'] == 'RedHat', 'stopped', 'running'),
      }
    PUPPET
  end

  context 'default parameters' do
    it 'works idempotently with no errors' do
      apply_manifest(pp, catch_failures: true)
      apply_manifest(pp, catch_changes: true)
    end

    describe package('bird') do
      it { is_expected.to be_installed }
    end

    describe service('bird') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    if fact('os.family') != 'Archlinux'
      describe service('bird6') do
        it { is_expected.to be_enabled }

        if fact('os.family') == 'RedHat'
          it { is_expected.not_to be_running }
        else
          it { is_expected.to be_running }
        end
      end
    end
  end
end
