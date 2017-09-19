require 'spec_helper'

describe 'steamcmd' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
			
			case os_facts[:os]['family']
			when 'windows'
				it { should contain_file('c:/steamcmd').with({
					'ensure' => 'directory'})
				}
			when 'linux'
				it { should contain_file('/opt/steamcmd').with({
					'ensure' => 'directory'})
				}
			end

    end
  end
end
