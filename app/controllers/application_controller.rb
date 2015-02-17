class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_reader :current_user

  # Auth section
  def authenticate
    unless current_user
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Bad credentials', status: 401
    end
  end

  def login_user(user)
    session = Session.new
    session.token = SecureRandom.hex
    session.ip_address = request.remote_ip
    session.user = user

    cookies[:auth_token] = {
      value: session.token,
      expires: Time.now + Session::TOKEN_EXPIRE_TIME,
      domain: :all,
    }

    session.save!
  end

  private
  def current_user
    authenticate_with_http_token do |token, options|
      set_user_with_token(token)
    end

    unless @current_user
      token = cookies[:auth_token]
      set_user_with_token(token)
    end

    @current_user
  end

  def set_user_with_token(token)
    session = Session.find_by(token: token)

    if session && session.token_valid?
      @current_user = session.user
    end
  end
end
