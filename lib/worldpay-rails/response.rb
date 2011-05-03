module Worldpay
  module Rails
    class Response

      def initialize(params, raw_post)
        # Thanks to Peter Cooper http://www.petercooper.co.uk/
        # http://snippets.dzone.com/posts/show/2191
        # for this line to merge the parameters from WorldPay
        @params = params.merge!(Hash[*raw_post.scan(/(\w+)\=(.+?)&/).flatten])
      end

      # checker methods

      def is_authorized_by_callback_password?(password = nil)
        if password.present?
          password == @params['callbackPW']
        else
          true
        end
      end

      def success?
        transaction_result == 'Y'
      end

      def amounts_match?(order_total)
        order_total == total
      end

      def currencies_match?(order_currency = 'GBP')
        order_currency == currency
      end

      # get details of order

      def order_ref
        @params['cartId'].to_i
      end

      def total
        @params['authAmount'].to_f
      end

      def transaction_ref
        @params['transId']
      end

      def transaction_result
        @params['transStatus']
      end

      def transaction_at
        Time.parse(@params['transTime'].to_i / 1000)
      end

      def currency
        @params['authCurrency']
      end

    end
  end
end