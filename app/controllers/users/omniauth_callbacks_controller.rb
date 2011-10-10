class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def google_apps
    return_to = session[:return_to] #but session is nil!

    @user = User.find_for_google_apps_oauth(env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = 'Logged in as ' + @user.email
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = 'User is not in the system'
      redirect_to root_url
    end
  end


  def failure
    tmp = 1
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end