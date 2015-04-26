class Payments::NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :current_user

  PAYPAL_STATUS_COMPLETED = 'Completed'

  def ipn
    case validate_ipn(request.raw_post)
    when 'VERIFIED'
      order = Payments::Order
        .includes(order_items: {product: :purchasable})
        .find_by(id: params[:invoice])

      notification = Payments::Notification.new
      notification.params = request.request_parameters
      notification.order = order
      notification.save

      if order
        # TODO: Check price and senders
        if params[:payment_status] == PAYPAL_STATUS_COMPLETED
          create_purchases_for_order(order)
          order.status = Payments::Order::STATUS_COMPLETED
        end

        order.transaction_id = params[:txn_id]
        order.save
      end
    when 'INVALID'
    else
    end

    render nothing: true
  end

  private
  def create_purchases_for_order(order)
    order.order_items.each do |order_item|
      purchase = Payments::Purchase.new
      purchase.user = order.user
      purchase.purchased = order_item.product.purchasable
      purchase.save
    end
  end

  def validate_ipn(raw)
    uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http.post(
      uri.request_uri,
      raw,
      'Content-Length' => "#{raw.size}",
      'User-Agent' => 'misteryio'
    ).body
  end
end
