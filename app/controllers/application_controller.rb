class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Auth section
  def authenticate
    unless current_user
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render_bad_credentials
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
    @current_user ||= begin
      authenticate_with_http_token do |token, options|
        user = user_with_token(token)
      end
      user = user_with_token(cookies[:auth_token]) unless user
    end
  end

  def user_with_token(token)
    session = Session.find_by(token: token)

    if session && session.token_valid?
      session.user
    end
  end

  def require_permission
    raise NotImplementedError
  end

  def render_bad_credentials
    render json: 'Bad credentials', status: 401
  end
end
