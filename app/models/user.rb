# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  providerName      :string(255)
#  identifier        :string(255)
#  verifiedEmail     :string(255)
#  prefferedUserName :string(255)
#  displayName       :string(255)
#  status            :string(255)
#  mobileNumber      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

# == Schema Information
#
# Table name: users
#
#  id                :integer          not null, primary key
#  providerName      :string(255)
#  identifier        :string(255)
#  verifiedEmail     :string(255)
#  prefferedUserName :string(255)
#  displayName       :string(255)
#  status            :string(255)
#  mobileNumber      :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class User < ActiveRecord::Base
  rolify
  attr_accessible :providerName, :identifier, :verifiedEmail, :prefferedUserName, :displayName, :status, :mobileNumber
  has_many :project_checklist_responses
  has_and_belongs_to_many :roles

  def has_role?(role_sym)
    roles.any? { |role| role.name.to_sym == role_sym}
  end
end
