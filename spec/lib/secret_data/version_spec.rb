require 'spec_helper'

describe SecretData do
  it { SecretData::VERSION.should eq('0.0.3'), "Please don't bump the version." }
end
