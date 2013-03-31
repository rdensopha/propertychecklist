class User < ActiveRecord::Base
  attr_accessible :providerName, :identifier, :verifiedEmail, :prefferedUserName, :displayName, :status, :mobileNumber
  has_many :project_checklist_responses
end
