require 'secret_data/version'
require 'secret_data/silencer'

##
# Example usage with VCR gem to silence api credentials.
#
#     require 'secret_data'
#     require 'vcr'
#
#     secret_data = SecretData.new(:yml_path => 'your_config.yml')
#     VCR.configure do |c|
#       secret_data.silence! do |find, replace|
#         c.filter_sensitive_data(replace) { find }
#       end
#     end
#
class SecretData
  ##
  # Configuration via block is also allowed.
  #
  #     require 'secret_data'
  #
  #     SecretData.new.configure {|config|
  #       config.message = '~*~GOODBYE_{{var}}~*~'  # optional
  #       config.add_from_env('API_SECRET')         # reads ENV['API_SECRET']
  #     }.silence!{|secret, message|
  #       puts "Have some ultra-confidential data: #{secret}!"
  #       puts "...whoops, I should have shown you #{message}."
  #     }
  # 
  def configure(&block)
    block.call(self)
    self
  end
end