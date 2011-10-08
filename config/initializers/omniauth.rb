# Rails.application.config.middleware.use OmniAuth::Builder do
#   # ALWAYS RESTART YOUR SERVER IF YOU MAKE CHANGES TO THESE SETTINGS!
#
#   # you need a store for OpenID; (if you deploy on heroku you need Filesystem.new('./tmp') instead of Filesystem.new('/tmp'))
#   #TODD-try in other project, is this necessary?
#   require 'openid/store/filesystem'
#
#   # dedicated openid
##   provider :google_apps, OpenID::Store::Filesystem.new('./tmp'), :domain => 'west.cmu.edu'
#
#end