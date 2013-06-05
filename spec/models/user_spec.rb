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

require 'spec_helper'

describe User do
  
end
