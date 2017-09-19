require 'spec_helper'

describe 'steamcmd' do
	test_on = {
		:facterversion  => '2.4',
		:hardwaremodels => ['x86_64', 'i386']
	}

  on_supported_os(test_on).each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
			
			case os_facts[:kernel]
			when 'windows'
				it { should contain_file('c:/steamcmd').with({
					'ensure' => 'directory'})
				}
			when 'Linux'
				it { should contain_file('/opt/steamcmd').with({
					'ensure' => 'directory'})
				}

				it { should contain_user('steamcmd') }

				case os_facts[:os]['family']
				when 'RedHat'
					if os_facts[:architecture] == 'x86_64'
						it { should contain_package('glibc.i686') }
						it { should contain_package('libstdc++.i686') }
					elsif os_facts[:architecture] == 'i386'
						it { should contain_package('glibc') }
						it { should contain_package('libstdc++') }
					end
				when 'Debian'
					if os_facts[:architecture] == 'x86_64'
						it { should contain_package('lib32gcc1') }
					end
				end
			end

    end
  end
end
