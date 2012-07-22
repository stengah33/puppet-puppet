require 'spec_helper'

describe 'puppet::master::mongrel::standalone' do
  OSES.each do |os|
    describe "When on #{os} with mysql" do
    let(:facts) { {
      :operatingsystem => os
    } }

      it do should contain_package('mongrel').with(
        'ensure' => 'present',
        'name'   => VARS[os]['mongrel']
      ) end

      it do should contain_service('puppetmaster').with(
        'ensure'    => 'running',
        'hasstatus' => 'true',
        'enable'    => 'true'
      ) end

      it do should contain_augeas('configure puppetmaster startup variables').with(
        'context' => "/files#{VARS[os]['puppetmaster_default']}",
        'changes' => VARS[os]['mongrel_settings']
      ) end
    end
  end
end
