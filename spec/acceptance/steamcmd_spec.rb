# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'steamcmd class' do
  # Apply the module with default parameters.
  context 'with default parameters' do
    let(:pp) { "class { 'steamcmd': }" }

    # Manifest should be idempotently applied (successfully the first time and
    # without changes the second time).
    it 'behaves idempotently' do
      idempotent_apply(pp)
    end

    describe file('/opt/steamcmd') do
      it { is_expected.to be_directory }
      it { is_expected.to be_mode 755 }
    end

    describe file('/opt/steamcmd/steamcmd.sh') do
      it { is_expected.to be_file }
      it { is_expected.to be_mode 755 }
    end
  end
end
