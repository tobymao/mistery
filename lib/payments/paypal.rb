module Payments
  class Paypal
    def initialize
      @api = PayPal::SDK::AdaptivePayments.new

      # Build request object
      @pay = @api.build_pay({
        actionType: "PAY",
        cancelUrl: "http://24.23.159.158/",
        currencyCode: "USD",
        feesPayer: "SENDER",
        ipnNotificationUrl: "http://24.23.159.158/payments/notifications/ipn",
        returnUrl: "http://localhost:3000/scenarios",
        receiverList: {
          receiver: [{
            amount: 1.0,
            email: 'misterydotio-facilitator@gmail.com'
          }]},
      })
    end

    def pay
      # Make API call & get response
      @response = @api.pay(@pay)

      # Access response
      if @response.success? && @response.payment_exec_status != "ERROR"
        @api.payment_url(@response)  # Url to complete payment
      else
        @response.error[0].message
      end
    end
  end
end
