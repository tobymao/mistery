class Payments::NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token, :current_user

  def ipn
    case validate_ipn(request.raw_post)
    when 'VERIFIED'
    when 'INVALID'
    else
    end

    render nothing: true
  end

  private
  def validate_ipn(raw)
    uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http.post(uri.request_uri, raw,
              'Content-Length' => "#{raw.size}",
              'User-Agent' => 'misteryio'
             ).body
  end
end
