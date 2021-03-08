class ApplicationController < ActionController::Base 
  helper_method :current_user_session, :current_user
  rescue_from User::NotAuthorized, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:error] = "You don't have access to this section 💔"
    redirect_back(fallback_location: root_path)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_login
    redirect_to sign_in_path unless current_user
  end
end
