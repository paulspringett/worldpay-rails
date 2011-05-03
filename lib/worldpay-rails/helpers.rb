module Worldpay
  module Rails
    module Helpers

      def uri
        Worldpay::Rails.uri
      end

      #generate html output for form tag
      def worldpay_form_tag(installation_id, cart_id, amount, options = {}, &block)

        params = {
          :instId => "#{installation_id}",
          :cartId => "#{cart_id}",
          :amount => "#{amount}",
          :currency => "GBP",
          :desc => "Purchase"
        }.merge(options)

        params.merge!({ :testMode => 100 }) if Worldpay::Rails.test?

        form_tag(uri) do
          hidden_fields = []
          params.each_pair do |name, value|
            hidden_fields << hidden_field_tag(name, value)
          end
          hidden_fields.join("\n") + capture(&block)
        end

      end

    end
  end
end
