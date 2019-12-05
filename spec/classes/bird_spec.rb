require 'spec_helper'

describe 'bird' do
  on_supported_os.each do |os, facts|
    case facts[:os]['family']
    when 'RedHat'
      filepath   = '/etc/bird.conf'
      filepathv6 = '/etc/bird6.conf'
    when 'Debian'
      filepath   = '/etc/bird/bird.conf'
      filepathv6 = '/etc/bird/bird6.conf'
    when 'Archlinux'
      filepath   = '/etc/bird.conf'
      filepathv6 = '/etc/bird.conf'
    end

    msg = if facts[:os]['name'] == 'Archlinux'
            %r{The bird version in Archlinux does not provide a seperate daemon for IPv6. You cannot explicitly enable it. The default daemon already has IPv6 support}
          else
            %r{either config_file_v6 or config_template_v6 or config_content_v6 parameter must be set}
          end

    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      context 'with only IPv4' do
        let(:params) do
          {
            config_file_v4: 'puppet:///modules/fooboozoo',
            enable_v6:      false,
            manage_conf: true,
            manage_service: true
          }
        end

        it { is_expected.not_to contain_yumrepo('bird') }
        it { is_expected.not_to contain_package('bird').that_requires('Yumrepo[bird]') }
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('bird') }
        it {
          is_expected.to contain_service('bird').with(
            'ensure'     => 'running',
            'hasstatus'  => 'false',
            'pattern'    => 'bird',
            'hasrestart' => 'false',
            'restart'    => '/usr/sbin/birdc configure'
          )
        }

        context 'with service (v4) and rc disabled' do
          let(:params) do
            {
              config_file_v4:    'puppet:///modules/fooboozoo',
              service_v4_ensure: 'stopped',
              manage_service: true
            }
          end

          it {
            is_expected.to contain_service('bird').with(
              'ensure'     => 'stopped',
              'enable'     => 'false',
              'hasstatus'  => 'false',
              'pattern'    => 'bird',
              'hasrestart' => 'false',
              'restart'    => '/usr/sbin/birdc configure'
            )
          }
        end

        it {
          is_expected.to contain_file(filepath).with(
            'source' => 'puppet:///modules/fooboozoo',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644'
          )
        }

        context 'without configuration file (IPv4)' do
          let(:params) { { manage_conf: false } }

          it { is_expected.to compile.with_all_deps }
          it { is_expected.not_to contain_file(filepath) }
        end
      end

      context 'with IPv4 and IPv6', if: facts[:os]['name'] != 'Archlinux' do
        let(:params) do
          {
            config_file_v4: 'puppet:///modules/fooboozoo',
            enable_v6:       true,
            config_file_v6:  'puppet:///modules/fooboozoo6',
            manage_conf: true,
            manage_service: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        if facts[:os]['family'] == 'RedHat'
          it { is_expected.to contain_package('bird6') }
        else
          it { is_expected.to contain_package('bird') }
        end
        it {
          is_expected.to contain_service('bird').with(
            'ensure'     => 'running',
            'hasstatus'  => 'false',
            'pattern'    => 'bird',
            'hasrestart' => 'false',
            'restart'    => '/usr/sbin/birdc configure'
          )
        }

        it {
          is_expected.to contain_file(filepath).with(
            'source' => 'puppet:///modules/fooboozoo',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644'
          ).that_notifies('Service[bird]')
        }

        it {
          is_expected.to contain_service('bird6').with(
            'ensure'     => 'running',
            'hasstatus'  => 'false',
            'pattern'    => 'bird6',
            'hasrestart' => 'false',
            'restart'    => '/usr/sbin/birdc6 configure'
          )
        }

        it {
          is_expected.to contain_file(filepathv6).with(
            'source' => 'puppet:///modules/fooboozoo6',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644'
          ).that_notifies('Service[bird6]')
        }

        context 'with service (v6) and rc disabled' do
          let(:params) do
            {
              service_v6_enable: false,
              service_v4_enable: false,
              config_file_v4:    'puppet:///modules/fooboozoo',
              manage_service:   true,
              enable_v6:         true,
              config_file_v6:    'puppet:///modules/fooboozoo6',
              service_v6_ensure: 'stopped',
              service_v4_ensure: 'stopped'
            }
          end

          it { is_expected.to compile.with_all_deps }

          it {
            is_expected.to contain_service('bird').with(
              'ensure'     => 'stopped',
              'enable'     => 'false',
              'hasstatus'  => 'false',
              'pattern'    => 'bird',
              'hasrestart' => 'false',
              'restart'    => '/usr/sbin/birdc configure'
            )
          }
          it {
            is_expected.to contain_service('bird6').with(
              'ensure'     => 'stopped',
              'enable'     => 'false',
              'hasstatus'  => 'false',
              'pattern'    => 'bird6',
              'hasrestart' => 'false',
              'restart'    => '/usr/sbin/birdc6 configure'
            )
          }
        end

        context 'without configuration file (IPv4/IPv6)' do
          let(:params) do
            {
              enable_v6:   true,
              manage_conf: false
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.not_to contain_file(filepath) }
          it { is_expected.not_to contain_file(filepathv6) }
        end
        context 'with manage_repo set to true' do
          let(:params) do
            {
              manage_repo: true
            }
          end

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_yumrepo('bird') }
          it { is_expected.to contain_package('bird') }
        end
        context 'with manage_repo set to true' do
          let(:params) do
            {
              config_content_v4: 'awesome bird configuration is expected here',
              config_content_v6: 'awesome bird configuration is expected here',
              enable_v6: true,
              manage_conf: true

            }
          end

          it { is_expected.to compile.with_all_deps }
          it {
            is_expected.to contain_file(filepath).with(
              'content' => 'awesome bird configuration is expected here',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644'
            )
          }
          it {
            is_expected.to contain_file(filepathv6).with(
              'content' => 'awesome bird configuration is expected here',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644'
            )
          }
        end
        context 'with config_file_v4 and config_template_v4' do
          let(:params) do
            {
              config_file_v4: '/path/to/file',
              config_template_v4: 'something',
              manage_conf: true
            }
          end

          it { is_expected.to compile.and_raise_error(%r{either config_file_v4 or config_template_v4 or config_content_v4 parameter must be set}) }
        end
        context 'with config_file_v4 and config_content_v4' do
          let(:params) do
            {
              config_file_v4: '/path/to/file',
              config_content_v4: 'content',
              manage_conf: true
            }
          end

          it { is_expected.to compile.and_raise_error(%r{either config_file_v4 or config_template_v4 or config_content_v4 parameter must be set}) }
        end
        context 'with config_template_v4 and config_content_v4' do
          let(:params) do
            {
              config_template_v4: '/path/to/file',
              config_content_v4: 'content',
              manage_conf: true
            }
          end

          it { is_expected.to compile.and_raise_error(%r{either config_file_v4 or config_template_v4 or config_content_v4 parameter must be set}) }
        end
        context 'with config_file_v6 and config_template_v6' do
          let(:params) do
            {
              config_file_v4: 'puppet:///modules/fooboozoo',
              config_file_v6: '/path/to/file',
              config_template_v6: 'something',
              manage_conf: true,
              enable_v6: true
            }
          end

          it { is_expected.to compile.and_raise_error(msg) }
        end
        context 'with config_file_v6 and config_content_v6' do
          let(:params) do
            {
              config_file_v4: 'puppet:///modules/fooboozoo',
              config_file_v6: '/path/to/file',
              config_content_v6: 'content',
              manage_conf: true,
              enable_v6: true
            }
          end

          it { is_expected.to compile.and_raise_error(msg) }
        end
        context 'with config_template_v6 and config_content_v6' do
          let(:params) do
            {
              config_file_v4: 'puppet:///modules/fooboozoo',
              config_template_v6: '/path/to/file',
              config_content_v6: 'content',
              manage_conf: true,
              enable_v6: true
            }
          end

          it { is_expected.to compile.and_raise_error(msg) }
        end
      end
    end
  end
end
