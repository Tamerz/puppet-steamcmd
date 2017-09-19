require 'spec_helper'

describe 'steamcmd' do
  on_supported_os(facterversion: '2.4').each do |os, os_facts|
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

				case os_facts[:os]['family']
				when 'RedHat'
					if os_facts[:architecture] == 'x86_64'
						it { should contain_package('glibc.i686') }
						it { should contain_package('libstdc++.i686') }
					elsif os_facts[:architecture] == 'x86'
						it { should contain_package('glibc') }
						it { should contain_package('libstdc++') }
					end
				end
			end

    end
  end
end
