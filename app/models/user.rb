class User < ActiveRecord::Base
  has_many :services

  attr_accessible :name, :email

  devise :omniauthable, :rememberable, :trackable, :timeoutable


  def self.find_for_google_apps_oauth(access_token, signed_in_resource=nil)
    email = access_token["user_info"]["email"]

    user = User.find_by_email(email)
    if user
    else
      user = User.create(:email => email)
    end
    user
  end

end