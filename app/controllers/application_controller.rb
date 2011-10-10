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
        # This should work, but session is lost. See https://github.com/plataformatec/devise/issues/1357
        # session[:return_to] = request.fullpath
        redirect_to user_omniauth_authorize_path(:google_apps, :origin => request.fullpath)
      end
    end

     def after_sign_in_path_for(resource)
        # This should work, but session is lost. See https://github.com/plataformatec/devise/issues/1357
        # return_to = session[:return_to]
        # session[:return_to] = nil
        return_to = request.env['omniauth.origin']
        stored_location_for(resource) || return_to || root_path
    end

end
