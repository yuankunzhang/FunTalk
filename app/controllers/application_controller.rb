class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :authorized?, except: ['init', 'consume']

  def authorized?
    if session[:authenticated].nil?
      redirect_to '/saml/init'
    end
  end
end
