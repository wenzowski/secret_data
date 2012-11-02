require 'yaml'
require 'erb'

class SecretData
  attr_accessor :message

  def initialize(opts={})
    @message  = '____SILENCED_{{var}}____'
    @secrets  = {}

    load_yaml!(opts[:yml_path]) if opts[:yml_path]
  end

  def configure(&block)
    block.call(self)
    self
  end

  ##
  # Iterates through each secret and display message pair.
  # 
  def silence(&block)
    @secrets.each_pair do |secret, message|
      block.call secret, message
    end
  end

  ##
  # Loads a secret from ENV using the environment variable name 
  # to generate an appropriate display message.
  def add_from_env(var_name)
    recursive_load(var_name => ENV[var_name])
  end

  ##
  # Loads secrets from a hash of variable name keys and 
  # corresponding secrets.
  def add(hash)
    recursive_load(nested_hash)
  end

  ##
  # Loads secrets from a YAML file of nested hashes, eg.
  #
  #     ---
  #     variable_name: secret_value
  #     nested_hash:
  #       another_variable: another_secret
  def load_yaml!(yml_path)
    nested_hash = YAML.load(ERB.new(File.read(yml_path)).result)
    recursive_load(nested_hash)
  end

  private

  def recursive_load(nested_hash, context='')
    nested_hash.each_pair do |key, val|
      case val
      when String
        @secrets[val] = message_for("#{context}#{key}")
      when Hash
        recursive_load(val, "#{context}#{key}_")
      end
    end
  end

  def message_for(key)
    @message.gsub /\{\{var\}\}/, "#{key.to_s}"
  end
end
