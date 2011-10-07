class ServicesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :signin, :signup, :newaccount, :failure]
  
  protect_from_forgery :except => :create     # see https://github.com/intridea/omniauth/issues/203

# callback: success
# This handles signing in and adding an authentication service to existing accounts itself
# It renders a separate view if there is a new user to create
def create
  # get the service parameter from the Rails router
  params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

  # get the full hash from omniauth
  omniauth = request.env['omniauth.auth']
  email = omniauth["user_info"]["email"]

  user = User.find_by_email(email)
  if user
    flash[:notice] = 'Logged in as ' + email
  else
    flash[:notice] = 'Creating account for ' + email
    user = User.create(:email => email)
  end
  session[:user_id] = user.id

  if session[:return_to]
    flash[:info] = 'session[:return_to] exists, so we are redirecting to ' + session[:return_to]
    redirect_to session[:return_to]
  else
    redirect_to root_url
  end


end


def signout
  if current_user
    session[:user_id] = nil
    session[:service_id] = nil
    session.delete :user_id
    session.delete :service_id
    flash[:notice] = 'You have been signed out!'
  end
  redirect_to root_url
end

end
