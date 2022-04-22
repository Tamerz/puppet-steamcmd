require 'spec_helper'

describe 'steamcmd' do
  test_on = {
    facterversion: '2.4',
    hardwaremodels: ['x86_64', 'i386'],
  }

  on_supported_os(test_on).each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      case os_facts[:kernel]
      when 'windows'
        it {
          is_expected.to contain_file('c:/steamcmd').with(
            'ensure' => 'directory',
            'owner'  => nil,
            'group'  => nil,
            'mode'   => nil,
          )
        }

        it {
          is_expected.to contain_archive('installer').with(
            'ensure'       => 'present',
            'path'         => 'c:/temp/steamcmd.zip',
            'extract'      => true,
            'extract_path' => 'c:/steamcmd',
            'source'       => 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip',
            'creates'      => 'c:/steamcmd/steamcmd.exe',
            'cleanup'      => true,
          )
        }

        it {
          is_expected.to contain_exec('initialize').with(
            'command' => 'c:/steamcmd/steamcmd.exe +login anonymous +quit',
            'cwd'     => 'c:/steamcmd',
            'creates' => 'c:/steamcmd/public',
            'returns' => [0, 7],
          )
        }

      when 'Linux'
        it {
          is_expected.to contain_file('/opt/steamcmd').with(
            'ensure' => 'directory',
            'owner'  => 'steamcmd',
            'group'  => 'steamcmd',
            'mode'   => '0755',
          ).that_requires('User[steamcmd]')
        }

        it {
          is_expected.to contain_user('steamcmd').with(
            'ensure' => 'present',
            'system' => true,
            'home'   => '/opt/steamcmd',
          )
        }

        it {
          is_expected.to contain_archive('installer').with(
            'ensure'       => 'present',
            'path'         => '/tmp/steamcmd_linux.tar.gz',
            'extract'      => true,
            'extract_path' => '/opt/steamcmd',
            'source'       => 'https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz',
            'creates'      => '/opt/steamcmd/steamcmd.sh',
            'cleanup'      => true,
            'user'         => 'steamcmd',
            'group'        => 'steamcmd',
          ).that_requires('User[steamcmd]')
        }

        it {
          is_expected.to contain_exec('initialize').with(
            'command' => '/opt/steamcmd/steamcmd.sh +login anonymous +quit',
            'cwd'     => '/opt/steamcmd',
            'user'    => 'steamcmd',
            'creates' => '/opt/steamcmd/public',
            'returns' => [0],
          )
        }

        case os_facts[:os]['family']
        when 'RedHat'
          it { is_expected.to contain_package('glibc.i686') }
          it { is_expected.to contain_package('libstdc++.i686') }
        when 'Debian'
          older_versions = ['9', '10', '18.04', '20.04']
          if older_versions.include? os_facts[:os]['release']['major']
            it { is_expected.to contain_package('lib32gcc1') }
          else
            it { is_expected.to contain_package('lib32gcc-s1') }
          end
        end
      end
    end
  end
end
