# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130410065853) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.integer  "parentCategory_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "project_checklist_responses", :force => true do |t|
    t.integer  "project_id"
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "status"
    t.integer  "responseValue"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "project_developers", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "status"
    t.integer  "project_developer_id"
    t.string   "projectType"
    t.string   "projectLocation"
    t.integer  "city_id"
    t.string   "slug"
  end

  add_index "projects", ["slug"], :name => "index_projects_on_slug"

  create_table "question_labels", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "question_labels_questions", :force => true do |t|
    t.integer "question_id"
    t.integer "question_label_id"
  end

  create_table "questions", :force => true do |t|
    t.text     "questionContent"
    t.string   "answerType"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "status"
    t.integer  "category_id"
    t.text     "question_info"
    t.string   "question_info_emphasis"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  create_table "users", :force => true do |t|
    t.string   "providerName"
    t.string   "identifier"
    t.string   "verifiedEmail"
    t.string   "prefferedUserName"
    t.string   "displayName"
    t.string   "status"
    t.string   "mobileNumber"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
