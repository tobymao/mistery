module Payments
  class Paypal
    def initialize
      @api = PayPal::SDK::AdaptivePayments.new

      # Build request object
      @pay = @api.build_pay({
        actionType: "PAY",
        cancelUrl: "http://localhost:3000/",
        currencyCode: "USD",
        feesPayer: "SENDER",
        ipnNotificationUrl: "http://localhost:3000/samples/adaptive_payments/ipn_notify",
        receiverList: {
          receiver: [{
            amount: 8.0,
            email: "platfo_1255612361_per@gmail.com" }] },
            returnUrl: "http://localhost:3000/scenarios" })
    end

    def pay
      # Make API call & get response
      @response = @api.pay(@pay)

      # Access response
      if @response.success? && @response.payment_exec_status != "ERROR"
        #@response.payKey
        @api.payment_url(@response)  # Url to complete payment
      else
        @response.error[0].message
      end
    end
  end
end
