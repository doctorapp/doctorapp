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

ActiveRecord::Schema.define(:version => 20130103080940) do

  create_table "appointments", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.string   "title"
    t.boolean  "allDay"
    t.datetime "start"
    t.datetime "end"
    t.string   "url"
    t.boolean  "editable"
    t.string   "source"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "appointments", ["doctor_id"], :name => "index_appointments_on_doctor_id"
  add_index "appointments", ["patient_id"], :name => "index_appointments_on_patient_id"

  create_table "calendar_settings", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "slotMinutes"
    t.integer  "minTime"
    t.integer  "maxTime"
    t.integer  "firstHour"
    t.integer  "defaultEventMinutes"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "doctors_domains", :id => false, :force => true do |t|
    t.integer "doctor_id", :null => false
    t.integer "domain_id", :null => false
  end

  add_index "doctors_domains", ["doctor_id", "domain_id"], :name => "index_doctors_domains_on_doctor_id_and_domain_id", :unique => true

  create_table "doctors_languages", :id => false, :force => true do |t|
    t.integer "doctor_id",   :null => false
    t.integer "language_id", :null => false
  end

  add_index "doctors_languages", ["doctor_id", "language_id"], :name => "index_doctors_languages_on_doctor_id_and_language_id", :unique => true

  create_table "domains", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "favorite_doctors", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "favorite_doctors", ["doctor_id", "patient_id"], :name => "index_favorite_doctors_on_doctor_id_and_patient_id", :unique => true
  add_index "favorite_doctors", ["doctor_id"], :name => "index_favorite_doctors_on_doctor_id"
  add_index "favorite_doctors", ["patient_id"], :name => "index_favorite_doctors_on_patient_id"

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.string   "password_digest"
    t.boolean  "active"
    t.string   "type"
    t.string   "remember_token"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"
  add_index "users", ["type"], :name => "index_users_on_type"

end
