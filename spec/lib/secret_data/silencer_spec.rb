require 'spec_helper'

describe SecretData do

  context '#initialize' do
    context 'with YAML', :fakefs do
      subject { SecretData.new :yml_path => 'config.yml' }

      before :each do
        File.open('config.yml', 'w') do |f| 
          f.write({
            'description' => 'secret',
            'nested' => {
              'another' => 'secret2'
            }
          }.to_yaml)
        end
      end

      it do 
        subject.instance_variable_get('@secrets').should == {
          'secret' => "____SILENCED_description____",
          'secret2' => "____SILENCED_nested_another____"
        }
      end
    end
  end

  context '#silence' do
    subject {
      ENV['VAR'] = 'secret data'
      SecretData.new.configure{|c| c.add_from_env('VAR') }
    }

    it do
      subject.silence {|secret, message|
        secret.should == 'secret data'
        message.should == '____SILENCED_VAR____'
      }
    end
  end

  context '#message_for' do
    subject { SecretData.new }

    context 'default message' do
      it do
        subject.send(
          :message_for, 'FOO'
        ).should == '____SILENCED_FOO____'
      end
    end

    context 'custom message' do
      it do
        subject.configure do |config|
          config.message = '{{var}}'
        end
        subject.send(:message_for, 'FOO').should == 'FOO'
      end
    end
  end


end