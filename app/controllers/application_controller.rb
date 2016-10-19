class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorized?, except: ['init', 'consume']

  def authorized?
    if session[:authenticated].nil?
      redirect_to '/saml/init'
    end
  end

  def current_user
    return unless session[:email]
    @current_user ||= User.find_by(email: session[:email])
  end
end
