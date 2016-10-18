require 'onelogin/ruby-saml'

class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def init
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    request = OneLogin::RubySaml::Authrequest.new
    response.settings = saml_settings
    if response.is_valid?
      session[:authenticated] = true
      redirect_to root_path
    else
      # redirect_to(request.create(saml_settings))
      render :status => 500
    end
  end

  private

  def saml_settings
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    settings = idp_metadata_parser.parse(idp_metadata)
    settings.assertion_consumer_service_url = "http://localhost:3000/saml/consume"
    settings.issuer = "oktademo"
    settings.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
    settings
  end

  def idp_metadata
    'https://dev-772843.oktapreview.com/app/exk8kcfswzm4ozujm0h7/sso/saml/metadata'
  end
end