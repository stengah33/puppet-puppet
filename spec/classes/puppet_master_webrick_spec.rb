require 'spec_helper'

describe 'puppet::master::webrick' do
  OSES.each do |os|
    describe "When on #{os} with mysql" do
      let(:facts) { {
        :operatingsystem => os
      } }

      it do should contain_augeas('configure puppetmaster startup variables').with(
        'context' => "/files#{VARS[os]['puppetmaster_default']}",
        'changes' => VARS[os]['webrick_settings']
      ) end

      it do should contain_service('puppetmaster').with(
        'ensure' => 'running',
        'enable' => 'true'
      ) end
    end
  end
end
