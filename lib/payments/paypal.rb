module Payments
  class Paypal
    include Rails.application.routes.url_helpers

    def initialize(cancel_url:, return_url:, product:)
      puts cancel_url
      puts return_url
      puts payments_notifications_ipn_url

      @api = PayPal::SDK::AdaptivePayments.new

      # Build request object
      @pay = @api.build_pay({
        actionType: "PAY",
        cancelUrl: cancel_url,
        currencyCode: "USD",
        feesPayer: "EACHRECEIVER",
        ipnNotificationUrl: payments_notifications_ipn_url,
        returnUrl: return_url,
        receiverList: {
          receiver: [{
            amount: 1.0,
            email: 'misterydotio-facilitator@gmail.com'
          }, {
            amount: 2.0,
            email: product.purchasable.user.payment_profile.email
          }]},
      })
    end

    def payment_url
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
