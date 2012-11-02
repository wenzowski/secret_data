require 'spec_helper'

describe SecretData do
  it { SecretData::VERSION.should eq('0.0.1'), "Please don't bump the version." }
end
