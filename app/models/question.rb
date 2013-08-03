# == Schema Information
#
# Table name: questions
#
#  id                     :integer          not null, primary key
#  questionContent        :text
#  answerType             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  status                 :string(255)
#  category_id            :integer
#  question_info          :text
#  question_info_emphasis :string(255)
#

# == Schema Information
#
# Table name: questions
#
#  id                     :integer          not null, primary key
#  questionContent        :text
#  answerType             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  status                 :string(255)
#  category_id            :integer
#  question_info          :text
#  question_info_emphasis :string(255)
#

class Question < ActiveRecord::Base
  #attributes are #answerType:string, #questionContent:text, #status:string,
  attr_accessible :answerType, :questionContent, :category_id, :question_label_ids, :question_info, :question_info_emphasis, :download_link_ids
  belongs_to :category, inverse_of:  :questions
  has_many :project_checklist_responses
  has_and_belongs_to_many :question_labels
  has_many :download_links
end
