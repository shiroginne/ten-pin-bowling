ActiveRecord::Schema.define(version: 2018_02_24_100022) do
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "author"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
