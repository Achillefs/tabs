class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  before_filter :set_session_browser
  
  def set_session_browser
    unless session[:browser]
      user_agent = request.env['HTTP_USER_AGENT'].to_s.downcase
      session[:browser] = if user_agent =~ /msie/i
        "ie"
      elsif user_agent =~ /konqueror/i
        "konqueror"
      elsif user_agent =~ /opera/i
        "opera"
      elsif user_agent =~ /chrome/i
        "chrome"
      elsif user_agent =~ /applewebkit/i
        "safari"
      elsif user_agent =~ /gecko/i
        "firefox"
      else
        "unknown"
      end
    end
  end
end
