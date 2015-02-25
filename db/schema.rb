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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150218062604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string   "login"
    t.string   "email"
    t.string   "password"
    t.boolean  "guest",      default: false, null: false
    t.boolean  "admin",      default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["email"], :name => "index_users_on_email", :unique => true, :case_sensitive => false
    t.index ["login"], :name => "index_users_on_login", :unique => true, :case_sensitive => false
  end

  create_table "universes", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], :name => "index_universes_on_name", :unique => true, :case_sensitive => false
    t.index ["user_id"], :name => "index_universes_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_universes_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "address",     null: false
    t.string   "name",        null: false
    t.integer  "universe_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["universe_id", "address"], :name => "index_locations_on_universe_id_and_address", :unique => true
    t.index ["universe_id"], :name => "fk__locations_universe_id"
    t.foreign_key ["universe_id"], "universes", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_locations_universe_id"
  end

  create_table "scenarios", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "solution"
    t.integer  "universe_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], :name => "index_scenarios_on_name", :unique => true, :case_sensitive => false
    t.index ["universe_id"], :name => "index_scenarios_on_universe_id"
    t.index ["user_id"], :name => "index_scenarios_on_user_id"
    t.foreign_key ["universe_id"], "universes", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_scenarios_universe_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_scenarios_user_id"
  end

  create_table "plays", force: :cascade do |t|
    t.boolean  "active",      null: false
    t.integer  "user_id",     null: false
    t.integer  "scenario_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["scenario_id"], :name => "index_plays_on_scenario_id"
    t.index ["user_id"], :name => "index_plays_on_user_id"
    t.foreign_key ["scenario_id"], "scenarios", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_plays_scenario_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_plays_user_id"
  end

  create_table "actions", force: :cascade do |t|
    t.integer  "play_id",     null: false
    t.integer  "location_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], :name => "fk__actions_location_id"
    t.index ["play_id", "location_id"], :name => "index_actions_on_play_id_and_location_id", :unique => true
    t.index ["play_id"], :name => "fk__actions_play_id"
    t.foreign_key ["location_id"], "locations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_actions_location_id"
    t.foreign_key ["play_id"], "plays", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_actions_play_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.text     "text"
    t.integer  "scenario_id", null: false
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], :name => "fk__contacts_location_id"
    t.index ["scenario_id", "location_id"], :name => "index_contacts_on_scenario_id_and_location_id", :unique => true
    t.index ["scenario_id"], :name => "fk__contacts_scenario_id"
    t.foreign_key ["location_id"], "locations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contacts_location_id"
    t.foreign_key ["scenario_id"], "scenarios", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_contacts_scenario_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "text",        null: false
    t.integer  "points",      null: false
    t.integer  "scenario_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["scenario_id"], :name => "index_questions_on_scenario_id"
    t.foreign_key ["scenario_id"], "scenarios", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_questions_scenario_id"
  end

  create_table "answers", force: :cascade do |t|
    t.integer  "question_id",                null: false
    t.boolean  "correct",     default: true, null: false
    t.integer  "location_id"
    t.integer  "contact_id"
    t.text     "text"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["contact_id"], :name => "fk__answers_contact_id"
    t.index ["location_id"], :name => "fk__answers_location_id"
    t.index ["question_id", "contact_id"], :name => "index_answers_on_question_id_and_contact_id", :unique => true
    t.index ["question_id", "location_id"], :name => "index_answers_on_question_id_and_location_id", :unique => true
    t.index ["question_id", "text"], :name => "index_answers_on_question_id_and_text", :unique => true
    t.index ["question_id"], :name => "index_answers_on_question_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_answers_contact_id"
    t.foreign_key ["location_id"], "locations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_answers_location_id"
    t.foreign_key ["question_id"], "questions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_answers_question_id"
  end

  create_table "guesses", force: :cascade do |t|
    t.integer  "play_id",     null: false
    t.integer  "question_id", null: false
    t.integer  "answer_id"
    t.integer  "location_id"
    t.integer  "contact_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["answer_id"], :name => "fk__guesses_answer_id"
    t.index ["contact_id"], :name => "fk__guesses_contact_id"
    t.index ["location_id"], :name => "fk__guesses_location_id"
    t.index ["play_id"], :name => "index_guesses_on_play_id"
    t.index ["question_id"], :name => "index_guesses_on_question_id"
    t.foreign_key ["answer_id"], "answers", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_guesses_answer_id"
    t.foreign_key ["contact_id"], "contacts", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_guesses_contact_id"
    t.foreign_key ["location_id"], "locations", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_guesses_location_id"
    t.foreign_key ["play_id"], "plays", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_guesses_play_id"
    t.foreign_key ["question_id"], "questions", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_guesses_question_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "token",      null: false
    t.string   "ip_address", null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["token"], :name => "index_sessions_on_token", :unique => true
    t.index ["user_id"], :name => "index_sessions_on_user_id"
    t.foreign_key ["user_id"], "users", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_sessions_user_id"
  end

end
