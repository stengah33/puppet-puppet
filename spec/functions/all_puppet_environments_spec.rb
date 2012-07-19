require 'spec_helper'

describe 'all_puppet_environments' do
  it { should run.with_params(nil).and_return(nil) }
end
