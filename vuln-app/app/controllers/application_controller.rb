class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_auth
    return render(status: 401, text: "auth failed") unless authed?
    session[:authed] = true
  end

  def authed?
    authed_by_session? || authed_by_token?
  end
  helper_method :authed?

  def authed_by_session?
    session[:authed] == true
  end

  def authed_by_token?
    Rack::Utils.secure_compare Rails.application.config.auth_token, params[:token].to_s
  end

  # Some views need to allow framing so other sites can embed them
  def allow_framing
    response.headers.delete "X-Frame-Options"
  end
end
