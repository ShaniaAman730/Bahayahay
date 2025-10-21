# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_21_084539) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accreditations", force: :cascade do |t|
    t.bigint "realty_id", null: false
    t.bigint "developer_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["developer_id"], name: "index_accreditations_on_developer_id"
    t.index ["realty_id"], name: "index_accreditations_on_realty_id"
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "amenities", force: :cascade do |t|
    t.string "name", null: false
    t.string "label"
    t.string "icon"
    t.integer "category", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_amenities_on_category"
    t.index ["name", "category"], name: "index_amenities_on_name_and_category", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "realtor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_conversations_on_client_id"
    t.index ["realtor_id"], name: "index_conversations_on_realtor_id"
  end

  create_table "dev_projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "barangay"
    t.integer "property_type"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["user_id"], name: "index_dev_projects_on_user_id"
  end

  create_table "dev_projects_model_houses", id: false, force: :cascade do |t|
    t.bigint "dev_project_id", null: false
    t.bigint "model_house_id", null: false
    t.index ["dev_project_id"], name: "index_dev_projects_model_houses_on_dev_project_id"
    t.index ["model_house_id"], name: "index_dev_projects_model_houses_on_model_house_id"
  end

  create_table "guides", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_guides_on_user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.integer "furnish_type"
    t.integer "project_type"
    t.integer "barangay"
    t.string "address"
    t.boolean "filipinocitizen"
    t.string "tin"
    t.boolean "ownerabroad"
    t.string "aif"
    t.boolean "provaircon", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "realtor_id", null: false
    t.bigint "client_id"
    t.string "listing_type"
    t.boolean "owneralive"
    t.boolean "estatetax"
    t.boolean "ejsprocessed"
    t.integer "citizenship"
    t.integer "listing_type_num"
    t.boolean "bank_financing", default: false, null: false
    t.boolean "inhouse_financing", default: false, null: false
    t.boolean "pagibig_financing", default: false, null: false
    t.integer "beds"
    t.integer "baths"
    t.integer "sqft"
    t.boolean "approved", default: false
    t.boolean "confirmed"
    t.integer "developer_id"
    t.integer "contact_clicks"
    t.boolean "active", default: true
    t.boolean "for_edit", default: false
    t.string "rejection_reason"
    t.string "custom_reason"
    t.integer "approval_requests_count", default: 0, null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["client_id"], name: "index_listings_on_client_id"
    t.index ["realtor_id"], name: "index_listings_on_realtor_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "sender_id"
    t.boolean "read", default: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "model_houses", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.integer "furnish_type"
    t.boolean "provaircon", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "beds"
    t.integer "baths"
    t.integer "sqft"
    t.boolean "bank_financing", default: false, null: false
    t.boolean "inhouse_financing", default: false, null: false
    t.boolean "pagibig_financing", default: false, null: false
    t.bigint "dev_project_id"
    t.index ["dev_project_id"], name: "index_model_houses_on_dev_project_id"
  end

  create_table "password_reset_logs", force: :cascade do |t|
    t.bigint "admin_id", null: false
    t.bigint "user_id", null: false
    t.string "new_password", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_password_reset_logs_on_admin_id"
    t.index ["user_id"], name: "index_password_reset_logs_on_user_id"
  end

  create_table "property_amenities", force: :cascade do |t|
    t.bigint "amenity_id", null: false
    t.string "property_type", null: false
    t.bigint "property_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["amenity_id"], name: "index_property_amenities_on_amenity_id"
    t.index ["property_type", "property_id", "amenity_id"], name: "index_property_amenities_on_property_and_amenity", unique: true
    t.index ["property_type", "property_id"], name: "index_property_amenities_on_property"
    t.index ["property_type", "property_id"], name: "index_property_amenities_on_property_type_and_property_id"
  end

  create_table "realties", force: :cascade do |t|
    t.string "name", null: false
    t.string "business_location"
    t.string "email"
    t.string "phone_number"
    t.integer "status", default: 0, null: false
    t.text "rejection_reason"
    t.bigint "head_broker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "about"
    t.string "website"
    t.index ["head_broker_id"], name: "index_realties_on_head_broker_id"
  end

  create_table "realty_memberships", force: :cascade do |t|
    t.bigint "realty_id", null: false
    t.bigint "user_id", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["realty_id"], name: "index_realty_memberships_on_realty_id"
    t.index ["user_id"], name: "index_realty_memberships_on_user_id"
  end

  create_table "rebap_memberships", force: :cascade do |t|
    t.integer "rebap_id"
    t.integer "member_id"
    t.string "chapter"
    t.string "role"
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["member_id"], name: "index_rebap_memberships_on_member_id", unique: true
    t.index ["order"], name: "index_rebap_memberships_on_order", unique: true, where: "(role IS NOT NULL)"
  end

  create_table "review_events", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "realtor_id", null: false
    t.bigint "listing_id", null: false
    t.string "event_type"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.bigint "review_id"
    t.index ["client_id"], name: "index_review_events_on_client_id"
    t.index ["listing_id"], name: "index_review_events_on_listing_id"
    t.index ["realtor_id"], name: "index_review_events_on_realtor_id"
    t.index ["review_id"], name: "index_review_events_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text "comment"
    t.bigint "listing_id", null: false
    t.bigint "client_id", null: false
    t.bigint "realtor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "knowledge_rating"
    t.integer "responsiveness_rating"
    t.integer "professionalism_rating"
    t.boolean "read", default: false
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["listing_id"], name: "index_reviews_on_listing_id"
    t.index ["realtor_id"], name: "index_reviews_on_realtor_id"
  end

  create_table "saved_listings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "listing_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["listing_id"], name: "index_saved_listings_on_listing_id"
    t.index ["user_id"], name: "index_saved_listings_on_user_id"
  end

  create_table "statistics", force: :cascade do |t|
    t.string "trackable_type", null: false
    t.bigint "trackable_id", null: false
    t.integer "event_type", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "visitor_id"
    t.index ["trackable_type", "trackable_id"], name: "index_statistics_on_trackable"
    t.index ["visitor_id"], name: "index_statistics_on_visitor_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "contact_no"
    t.integer "user_type"
    t.string "address"
    t.string "company_name"
    t.boolean "admin_approved", default: false, null: false
    t.string "prc_no"
    t.string "dhsud_no"
    t.text "about"
    t.string "website"
    t.boolean "is_broker", default: false
    t.string "broker_name"
    t.string "broker_prc_no"
    t.boolean "privacy_agreement"
    t.datetime "welcome_email_sent_at"
    t.datetime "realtor_approval_email_sent_at"
    t.datetime "realtor_rejection_email_sent_at"
    t.boolean "email_sent"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accreditations", "realties"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "users", column: "client_id"
  add_foreign_key "conversations", "users", column: "realtor_id"
  add_foreign_key "dev_projects", "users"
  add_foreign_key "guides", "users"
  add_foreign_key "listings", "users", column: "client_id"
  add_foreign_key "listings", "users", column: "realtor_id"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "model_houses", "dev_projects"
  add_foreign_key "password_reset_logs", "users"
  add_foreign_key "password_reset_logs", "users", column: "admin_id"
  add_foreign_key "property_amenities", "amenities"
  add_foreign_key "realty_memberships", "realties"
  add_foreign_key "realty_memberships", "users"
  add_foreign_key "review_events", "listings"
  add_foreign_key "review_events", "reviews"
  add_foreign_key "review_events", "users", column: "client_id"
  add_foreign_key "review_events", "users", column: "realtor_id"
  add_foreign_key "reviews", "listings"
  add_foreign_key "reviews", "users", column: "client_id"
  add_foreign_key "reviews", "users", column: "realtor_id"
  add_foreign_key "saved_listings", "listings"
  add_foreign_key "saved_listings", "users"
  add_foreign_key "statistics", "users", column: "visitor_id", on_delete: :nullify
end
