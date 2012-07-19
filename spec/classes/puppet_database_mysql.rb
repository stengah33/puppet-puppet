require 'spec_helper'

describe 'puppet::database::mysql' do
  let(:facts) { {
    :puppetdbname => 'puppetdb',
    :puppetdbuser => 'puppet',
    :puppetdbpw  => 'P@s5w0Rd'
  } }

  it { should include_class('mysql::server') }

  it { should contain_mysql__database('puppet').with_ensure('present') }

  it do should contain_mysql__rights('Set rights for puppet database').with(
    'host'     => '%',
    'database' => 'puppetdb',
    'user'     => 'puppet',
    'password' => 'P@s5w0Rd'
  ) end
end
