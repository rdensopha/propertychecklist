class User < ActiveRecord::Base
  rolify
  attr_accessible :providerName, :identifier, :verifiedEmail, :prefferedUserName, :displayName, :status, :mobileNumber
  has_many :project_checklist_responses
  has_and_belongs_to_many :roles

  def has_role?(role_sym)
    roles.any? { |role| role.name.to_sym == role_sym}
  end
end
