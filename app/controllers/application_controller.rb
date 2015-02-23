class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  # Auth section
  def authenticate
    unless current_user
      respond_to do |format|
        format.html do
          session[:return_to] = request.fullpath
          redirect_to(login_url)
        end

        format.json do
          self.headers['WWW-Authenticate'] = 'Token realm="Application"'
          render_bad_credentials
        end
      end
    end
  end

  def login_user(user)
    s = Session.create({
      token: SecureRandom.hex,
      ip_address: request.remote_ip,
      user: user,
    })

    respond_to do |format|
      format.html do
        cookies[:auth_token] = {
          value: s.token,
          expires: Time.now + Session::TOKEN_EXPIRE_TIME,
          domain: :all,
        }

        url = session[:return_to] || root_path
        session[:return_to] = nil
        redirect_to(url)
      end

      format.json do
        render json: s.token
      end
    end
  end

  def current_user
    @current_user ||= begin
      user = user_with_token(cookies[:auth_token])

      authenticate_with_http_token do |token, options|
        user = user_with_token(token)
      end unless user

      user
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
