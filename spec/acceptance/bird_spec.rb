require 'spec_helper_acceptance'

describe 'bird class' do
  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'works idempotently with no errors' do
      pp = <<-EOS
      class { '::bird':
        manage_service => true,
        service_v4_enable => true,
        enable_v6 => true,
        service_v6_enable => true
      }
      EOS

      # Run it twice and test for idempotency
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

    describe service('bird6') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end
  end
end
