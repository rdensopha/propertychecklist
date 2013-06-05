# == Schema Information
#
# Table name: download_links
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  status      :string(255)
#  url         :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DownloadLink < ActiveRecord::Base
  attr_accessible :name, :status, :url
  belongs_to :question
  
  #validations
  validates :name,:url, :presence => true
  validates(:status,presence: true,
             inclusion: {
                        in: [APP_CONFIG.fetch('inactive'),APP_CONFIG.fetch('active')],
                        message: "%{value} is not a valid status"
             })
end
