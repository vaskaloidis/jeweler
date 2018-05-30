ActiveRecord::Schema.define(version: 2018_05_04_164900) do

  enable_extension "plpgsql"

  create_table "discussions", force: :cascade do |t|
    t.bigint "note_id"
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_id"], name: "index_discussions_on_note_id"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.string "email"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_invitations_on_project_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.text "description"
    t.decimal "hours"
    t.decimal "rate", default: "0.0"
    t.string "item_type"
    t.boolean "complete", default: false
    t.bigint "sprint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "planned_hours"
    t.integer "position", null: false
    t.boolean "deleted", default: false
    t.index ["sprint_id"], name: "index_tasks_on_sprint_id"
    t.index ["position"], name: "index_tasks_on_position"
  end

  create_table "sprints", force: :cascade do |t|
    t.date "payment_due_date"
    t.boolean "payment_due", default: false
    t.text "description"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "open", default: false
    t.integer "sprint"
    t.index ["project_id"], name: "index_sprints_on_project_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "content"
    t.integer "note_type", default: 1
    t.string "git_commit_id"
    t.bigint "project_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.boolean "sync", default: false
    t.bigint "sprint_id"
    t.bigint "task_id"
    t.string "commit_diff_path"
    t.integer "event_type"
    t.index ["sprint_id"], name: "index_notes_on_sprint_id"
    t.index ["task_id"], name: "index_notes_on_task_id"
    t.index ["project_id"], name: "index_notes_on_project_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "payment_type"
    t.string "payment_identifier"
    t.string "payment_note"
    t.decimal "amount"
    t.bigint "sprint_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sprint_id"], name: "index_payments_on_sprint_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "project_customers", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.string "invitation"
    t.boolean "v1_tour", default: false
    t.index ["project_id"], name: "index_project_customers_on_project_id"
    t.index ["user_id"], name: "index_project_customers_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.string "language"
    t.text "description"
    t.string "github_url"
    t.string "readme_file", default: "README.md"
    t.boolean "readme_remote", default: false
    t.string "stage_website_url"
    t.string "demo_url"
    t.string "prod_url"
    t.boolean "complete", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "github_branch", default: "master"
    t.string "image"
    t.bigint "task_id"
    t.integer "sprint_total"
    t.integer "sprint_current"
    t.string "heroku_token"
    t.string "google_analytics_tracking_code"
    t.index ["github_url"], name: "index_projects_on_github_url", unique: true
    t.index ["task_id"], name: "index_projects_on_task_id"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "location"
    t.string "website_url"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "tagline"
    t.string "image"
    t.string "company", default: ""
    t.string "oauth"
    t.string "stripe_account_id"
    t.string "stripe_type"
    t.string "stripe_token"
    t.string "stripe_key"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "discussions", "notes"
  add_foreign_key "discussions", "users"
  add_foreign_key "invitations", "projects"
  add_foreign_key "notes", "tasks"
  add_foreign_key "notes", "sprints"
  add_foreign_key "notes", "projects"
  add_foreign_key "notes", "users"
end
