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

ActiveRecord::Schema.define(version: 20180824175344) do

  create_table "lists", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "task_id",    null: false
    t.integer  "user_id",    null: false
    t.integer  "state_id",   null: false
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_logs_on_state_id"
    t.index ["task_id"], name: "index_logs_on_task_id"
    t.index ["user_id"], name: "index_logs_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_roles_on_role", unique: true
  end

  create_table "states", force: :cascade do |t|
    t.string   "state",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_states_on_state", unique: true
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "list_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_tasks_on_list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                        null: false
    t.string   "email",                       null: false
    t.string   "username",                    null: false
    t.string   "password_digest",             null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role_id",         default: 2, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_lists", force: :cascade do |t|
    t.integer  "list_id",                    null: false
    t.integer  "user_id",                    null: false
    t.boolean  "is_owner",   default: false, null: false
    t.boolean  "visible",    default: false, null: false
    t.boolean  "can_edit",   default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["list_id"], name: "index_users_lists_on_list_id"
    t.index ["user_id"], name: "index_users_lists_on_user_id"
  end

end
