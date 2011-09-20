#### Worldpay HTML Redirect Rails Plugin

Copyright (c) 2008 Paul Springett [http://paulspringett.name], released under the MIT license

This plugin helps in creating the HTML form for submitting payment information to WorldPay and includes methods for easily handling the callback response from WorldPay

When in development mode payments are submitted to the test page (and the testMode=100 POST parameter is added to the form). In production mode, requests are sent to the live payment page

#### Todo

* Custom notification URL
* FuturePay Support

#### Example

Create redirect HTML form:

	# in your controller
	
	def new
		
		# set options for submitting to WorldPay
		@worldpay_options = {
		  :desc => "Store Purchase",
		  :currency => "CAD", # default is USD
		  :name => "Joe Bloggs",
		  :address => "123 A Street, Some City",
		  :postcode => "DC 20500", # billing zip/postcode
		  :country => "US", # ISO3166 2 letter country code, see http://en.wikipedia.org/wiki/ISO_3166-1_alpha-2
		  :tel => "000-000 00000 000",
		  :email => "user@example.com"
		}

	end

	# in app/views/order/new.html.erb

	<%= worldpay_form_tag(002448, "#384838-4545", 1684.45, @worldpay_options) do %>
		<%= submit_tag 'Pay with Worldpay' %>
	<% end %>

	# these parameters are handled as follows:

	# in lib/helpers.rb
	# Worldpay::InstanceMethods

	def worldpay_form_tag(installation_id, order_ref, amount, options = {})

		# installation_id is the installation ID from your worldpay environment
		# order_ref stores the order number - this is passed back by WorldPay in the payment response callback
		# amount is the money to charge (as a float) (you can set currency as :currency => "XYZ" in the options hash)
		# options - additional details to send to WorldPay
		
	end

#### Handling Payment Notification Response

	# in an example callback controller
	# app/controllers/transaction_controller.rb
	# set callback URL to example.com/transactions/worldpay_callback

	class TransactionController < ApplicationController
  	
		# stop rails from throwing exception
		skip_before_filter :verify_authenticity_token
  
		def worldpay_callback
			
			# parse response parameters into new Worldpay::Rails::Response object
			notification = Worldpay::Response.new(params, request.raw_post)

			# find the relevant order from the db
			order = Order.find_by_reference(notification.order_ref)
			
			# validate callback by password from wp admin and valid order ref
			# callback password can be set in the WorldPay admin system
			if notification.is_authorized_by_callback_password?('password') and order
				
				# check payment response is valid
				# and transaction was successful
				if notification.success?
					
					if notification.currencies_match?('USD')
						# order is valid and has been paid for
						unless notification.amounts_match?(order.total)
							# order amount and amount paid for didn't match
						end
					else
						# payment received in different currency than expected
					end
        
					# save order
					# deliver confirmation email to customer
					
				end # success?
      
			end # is_authorized_by_callback_password
			
	    render :nothing => true
    	
	  end
  
	end

Copyright (c) 2008 Paul Springett [http://paulspringett.name], released under the MIT license