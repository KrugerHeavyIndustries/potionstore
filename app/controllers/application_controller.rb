class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  def check_authentication
    unless session[:logged_in]
      session[:intended_url] = request.url
      logger.debug('intended_url: ' + session[:intended_url])
      redirect_to :controller => "/admin", :action => "login"
    end
  end

end


# Convenience global function to check if we're running in production mode
def is_live?
  return Rails.env == 'production'
end


# Load store preferences
def load_store_prefs
  app_root = File.dirname(__FILE__) + '/../..'
  config_dir = app_root + '/config/'

  ymlpath = File.expand_path(config_dir + 'store.yml')
  $STORE_PREFS = YAML.load(File.open(ymlpath))
end

load_store_prefs()


# Convenience global function for rounding to monetary amount
def round_money(amount)
  return ("%01.2f" % amount).to_f()
end
