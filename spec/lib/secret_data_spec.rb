require 'spec_helper'

describe SecretData do
  it do
    expect { SecretData.new }.to_not raise_error
  end
end
