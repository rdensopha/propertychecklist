# == Schema Information
#
# Table name: categories
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  status            :string(255)
#  parentCategory_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

#this domain model has attributes #name, #status
#any object of Category  has @category.subcategories and @category.parentCategory
#the table categories has column -- parentCategory_id
class Category < ActiveRecord::Base
  attr_accessible :name, :status
  has_many :subcategories, class_name: 'Category', foreign_key: 'parentCategory_id'
  belongs_to :parentCategory, class_name: 'Category'
  #assciation with question model
  has_many :questions, inverse_of:  :category, dependent: :nullify
  #validations for category object
  validates :name, presence: true

end
