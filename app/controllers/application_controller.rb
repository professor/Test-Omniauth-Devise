class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :user_signed_in?

  private
    def user_signed_in?
      return 1 if current_user
    end

    def authenticate_user!
      if !current_user
        flash[:error] = 'You need to sign in before accessing this page!'

        session[:return_to] = request.fullpath
        redirect_to "/users/auth/google_apps"
      end
    end

     def after_sign_in_path_for(resource)
        session_return_to = session[:return_to]
        session[:return_to] = nil
        stored_location_for(resource) || session_return_to || root_path
    end

end
