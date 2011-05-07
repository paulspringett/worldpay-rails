module Worldpay
  module Rails
    
    def self.uri
      Worldpay.in_production? ? "https://secure.wp3.rbsworldpay.com/wcc/purchase" : "https://select-test.wp3.rbsworldpay.com/wcc/purchase"
    end

    def self.test?
      @@test_mode || not Worldpay.in_production?
    end
    
    # can set this in your environment files
    def self.test_mode=(value = false)
      @@test_mode = value
    end

    def self.in_production?
      Rails.env.production?
    end

  end
end

class ActionView::Base
  include Worldpay::Rails::Helpers
end
