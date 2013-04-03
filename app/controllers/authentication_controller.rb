require 'httparty'
class AuthenticationController < ApplicationController
  include HTTParty
  base_uri "rpxnow.com/api/v2/auth_info"
  def loginuser
    id_token = params[:token]
    response = self.class.get("", query: {apiKey: '05ba9498635b1de3a2a7485954e128de1572b2d8', token: id_token})
    session[:current_user_id] = process_user_info response.parsed_response if response.code == 200
    respond_to do |format|
      format.html {redirect_to projects_path}
    end
  end

  def logout
    session.clear
    respond_to do |format|
      format.html {redirect_to projects_path}
    end
  end
  private
  def process_user_info(user_info)
        identity_provider = user_info.fetch("profile").fetch("providerName")
        identifier_value = case identity_provider
                             when "Facebook" then user_info.fetch("profile").fetch("identifier").split("=")[1]
                             when "Google" then user_info.fetch("profile").fetch("googleUserId")
                           end
        user_loggedin = User.where(providerName: identity_provider,identifier: identifier_value).first_or_create(
            providerName: identity_provider,
            identifier: identifier_value,
            verifiedEmail: user_info.fetch("profile").fetch("verifiedEmail"),
            prefferedUserName: user_info.fetch("profile").fetch("preferredUsername"),
            displayName: user_info.fetch("profile").fetch("displayName"),
            status: 'Active',
            mobileNumber: nil)

  end
end
