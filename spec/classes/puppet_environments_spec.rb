require 'spec_helper'

describe 'puppet::environments' do
  # Function all_puppet_environments() returns nil
  it { should contain_puppet__config('main/environments').with_value(nil) }
end
