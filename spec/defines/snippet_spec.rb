# frozen_string_literal: true

require 'spec_helper'

describe 'bird::snippet' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :pre_condition do
        "class{'bird': manage_service => true, manage_conf => true, config_content_v4 => 'foobar'}"
      end

      context 'without params' do
        let(:title) { 'AS1234' }

        it { is_expected.to compile.and_raise_error(%r{you need to set}) }
      end

      context 'with too many params' do
        let(:title) { 'AS1234' }
        let :params do
          {
            source: 'puppet:///something',
            content: 'foobar'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{you can only set}) }
      end

      context 'with content' do
        let(:title) { 'AS1234' }
        let :params do
          {
            content: 'foobar'
          }
        end

        it { is_expected.to compile.with_all_deps }

        if %w[Archlinux CentOS].include?(os_facts[:os]['name'])
          it { is_expected.not_to contain_file('/etc/bird/snippets').with_ensure('directory') }
          it { is_expected.not_to contain_file('/etc/bird/snippets/AS1234').with_ensure('file') }
          it { is_expected.to contain_file('/etc/snippets/AS1234') }
          it { is_expected.to contain_file('/etc/snippets') }
        else
          it { is_expected.to contain_file('/etc/bird/snippets').with_ensure('directory') }
          it { is_expected.to contain_file('/etc/bird/snippets/AS1234').with_ensure('file') }
          it { is_expected.not_to contain_file('/etc/snippets/AS1234') }
          it { is_expected.not_to contain_file('/etc/snippets') }
        end
      end

      context 'with source' do
        let(:title) { 'AS1234' }
        let :params do
          {
            content: 'puppet:///something'
          }
        end

        it { is_expected.to compile.with_all_deps }
      end
    end
  end
end
