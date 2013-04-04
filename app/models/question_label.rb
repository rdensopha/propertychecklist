class QuestionLabel < ActiveRecord::Base
  attr_accessible :name, :status
  has_and_belongs_to_many :questions
end
