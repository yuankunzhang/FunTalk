require 'onelogin/ruby-saml'

class SamlController < ApplicationController
  skip_before_action :verify_authenticity_token

  def init
    OneLogin::RubySaml::Logging.logger = Logger.new(STDOUT)
    request = OneLogin::RubySaml::Authrequest.new
    redirect_to(request.create(saml_settings))
    # email = 'yuankun.zhang@funplus.com'
    # first_name = 'Yuankun'
    # last_name = 'Zhang'
    # User.find_or_create_by(email: email, first_name: first_name, last_name: last_name)
    #
    # session[:authenticated] = true
    # session[:email] = email
    # redirect_to root_path
  end

  def consume
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    response.settings = saml_settings
    if response.is_valid?
      attributes = response.attributes
      email = attributes[:Email]
      first_name = attributes[:FirstName]
      last_name = attributes[:LastName]
      User.find_or_create_by(email: email, first_name: first_name, last_name: last_name)
      session[:email] = email
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
    settings.assertion_consumer_service_url = "http://hobnmzfazp.localtunnel.me/saml/consume"
    settings.issuer = "http://hobnmzfazp.localtunnel.me/saml/consume"
    settings.name_identifier_format = "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
    settings
  end

  def idp_metadata
    '<?xml version="1.0" encoding="UTF-8"?><md:EntityDescriptor xmlns:md="urn:oasis:names:tc:SAML:2.0:metadata" entityID="http://www.okta.com/exk8yj79ww332pLjw0x7"><md:IDPSSODescriptor WantAuthnRequestsSigned="false" protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol"><md:KeyDescriptor use="signing"><ds:KeyInfo xmlns:ds="http://www.w3.org/2000/09/xmldsig#"><ds:X509Data><ds:X509Certificate>MIIDnjCCAoagAwIBAgIGAUtSOSvbMA0GCSqGSIb3DQEBBQUAMIGPMQswCQYDVQQGEwJVUzETMBEG
A1UECAwKQ2FsaWZvcm5pYTEWMBQGA1UEBwwNU2FuIEZyYW5jaXNjbzENMAsGA1UECgwET2t0YTEU
MBIGA1UECwwLU1NPUHJvdmlkZXIxEDAOBgNVBAMMB2Z1bnBsdXMxHDAaBgkqhkiG9w0BCQEWDWlu
Zm9Ab2t0YS5jb20wHhcNMTUwMjA0MDEzMzEzWhcNNDUwMjA0MDEzNDEzWjCBjzELMAkGA1UEBhMC
VVMxEzARBgNVBAgMCkNhbGlmb3JuaWExFjAUBgNVBAcMDVNhbiBGcmFuY2lzY28xDTALBgNVBAoM
BE9rdGExFDASBgNVBAsMC1NTT1Byb3ZpZGVyMRAwDgYDVQQDDAdmdW5wbHVzMRwwGgYJKoZIhvcN
AQkBFg1pbmZvQG9rdGEuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0rKx+vzC
Jlqr3RKNh745sxbJsv0T9khKnVJoDnI82P7Ga92eAGvHncVKhCUQX67OI9I9L7H6HRuf6B9yb1PK
6VBEoV1sMnP6bFwp8H/Vv3ucJ2GIghqjRgpkDGkPrGDuWhdksvDEsSxF3Kv/RnPLvgEJA7vUfi5a
8tUqLgKMHRvIgmNwJ/waYgi0TUSeT0Lsl2c++RG6wRv9jZB/JYv3vjr1GPkdXhRQCeLIVvIbZucC
aZ58tQ5Gtv5l4AT+NsYnva/LNE35B01layYEilh4JwkOBkzgd5i6UiY84YwhlftQiTl7neJwTjD6
ah2ysdAZuG5fY+qBLszV6kq+cRlfnQIDAQABMA0GCSqGSIb3DQEBBQUAA4IBAQBjWNDvTNRCF5sj
waX7Kt0uvzxnVdTs32pZJY6gqVkLdotUudEcMrz4nM8Xu9ENt2hKE0PkewGnmx7N2qWfVRFlkmFu
l+N8xvq+R5mtYoO8pw3lQwQBBGNvY+XDU0InkFUQOCcCJJyNz4tazbfOT6EvsQ+wNW145ckqw2dF
SNlqExMHS4lflbcOMKFfvM9cTkwMWmiaZlnFwAjrguo0pIl6TXcBv4eEV/qjq8SXAjXbh8Bd2I2k
oUNPGhPKqr451IvI2cL0rwkJS3r8yBcTtiE9CTYP9apZGqPXUq4gRfaoEBI1re9v7w29BL6U793W
ro0vLKXZi+AGKn07bjJjmb7h</ds:X509Certificate></ds:X509Data></ds:KeyInfo></md:KeyDescriptor><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress</md:NameIDFormat><md:NameIDFormat>urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified</md:NameIDFormat><md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" Location="https://funplus.okta.com/app/funplus_funtalk_1/exk8yj79ww332pLjw0x7/sso/saml"/><md:SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://funplus.okta.com/app/funplus_funtalk_1/exk8yj79ww332pLjw0x7/sso/saml"/></md:IDPSSODescriptor></md:EntityDescriptor>'
  end
end
