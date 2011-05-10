puts "loading lib/worldpay.rb"
require File.join(File.dirname(__FILE__), "worldpay/railtie.rb")

module Worldpay
  autoload :Response, File.join(File.dirname(__FILE__), "worldpay/response")
  autoload :InstanceMethods, File.join(File.dirname(__FILE__), "worldpay/helpers")
  
  @@test_mode = false
  
  def self.uri
    if Worldpay.test?
      "https://select-test.wp3.rbsworldpay.com/wcc/purchase"
    else
      "https://secure.wp3.rbsworldpay.com/wcc/purchase"
    end
  end

  def self.test?
    @@test_mode || (not Worldpay.in_production?)
  end
  
  # can set this in your environment files
  def self.test_mode=(value = false)
    @@test_mode = value
  end

  def self.in_production?
    Rails.env.production?
  end
  
end
