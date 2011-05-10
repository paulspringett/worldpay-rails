require 'rails'
require 'worldpay'

p "Railtie loaded"

begin
module Worldpay
  class Railtie < Rails::Railtie
    config.to_prepare do
      p "hook added"
      ActionView::Base.send(:include, Worldpay::InstanceMethods)
    end
  end
end
rescue
p $!, $!.message
raise $!
end