require 'spec_helper'

describe 'steamcmd::game' do
  let(:title) { 'namevar' }
  let(:pre_condition) { 'class { "steamcmd": }' }
  let(:params) do
    { 'game_id' => 258_550 }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      case os_facts[:kernel]
      when 'windows'

        it {
          is_expected.to contain_exec('install').with(
            'command' => 'c:/steamcmd/steamcmd.exe +login anonymous +force_install_dir \'c:/steamcmd/namevar\' +app_update 258550 +quit',
          )
        }
      when 'Linux'

        it {
          is_expected.to contain_exec('install').with(
            'command' => '/opt/steamcmd/steamcmd.sh +login anonymous +force_install_dir \'/opt/steamcmd/namevar\' +app_update 258550 +quit',
            'user'    => 'steamcmd',
            'group'   => 'steamcmd',
          )
        }
      end
    end
  end
end
