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

ActiveRecord::Schema.define(:version => 20130112101100) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contents", :force => true do |t|
    t.string   "date"
    t.string   "team1"
    t.integer  "team1core"
    t.string   "team2"
    t.integer  "team2score"
    t.string   "fdm"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "journeecategorielinks", :force => true do |t|
    t.integer  "journee_id"
    t.integer  "categorie_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "journeecontentlinks", :force => true do |t|
    t.integer  "journee_id"
    t.integer  "content_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "journees", :force => true do |t|
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "resultatcategorielinks", :force => true do |t|
    t.integer  "resultat_id"
    t.integer  "categorie_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "resultats", :force => true do |t|
    t.string   "rang"
    t.string   "team"
    t.integer  "points"
    t.integer  "journee"
    t.integer  "gagne"
    t.integer  "nuls"
    t.integer  "butplus"
    t.integer  "butmoins"
    t.integer  "diff"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "perdu"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.integer  "birthdate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
