require 'httparty'
require 'firebase_token_generator'
class AuthenticationController < ApplicationController
  include HTTParty
  base_uri "rpxnow.com/api/v2/auth_info"
  def loginuser
    id_token = params[:token]
    @project = Project.find(params[:id])
    response = self.class.get("", query: {apiKey: ENV["JANRAIN_KEY"], token: id_token})
    session[:current_user_id] = (process_user_info response.parsed_response).id  if response.code == 200
    session[:firebase_auth_id] = generate_token_firebase_client(id_token)
    respond_to do |format|
      format.html {redirect_to project_path(@project)}
    end
  end

  def logout
    session.clear
    respond_to do |format|
      format.html {redirect_to root_path}
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
        if !(user_loggedin.has_role?(:projectMember)||user_loggedin.has_role?(:admin))
              user_loggedin.add_role :projectMember
        end
        user_loggedin
  end

  def generate_token_firebase_client(token_id)
    firebase_secret = ENV["FIREBASE_SECRET_KEY"]
    options = {expires: DateTime.parse(Time.current.advance(hours:24).to_s).to_time.to_i}
    auth_data = {user_token_data: token_id}
    generator = Firebase::FirebaseTokenGenerator.new(firebase_secret)
    token = generator.create_token(auth_data, options)
  end
end
