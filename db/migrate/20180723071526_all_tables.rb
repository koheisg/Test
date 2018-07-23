class AllTables < ActiveRecord::Migration[5.1]
  def change
    create_table "event_categories", force: :cascade do |t|
      t.bigint "event_id"
      t.string "category"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_event_categories_on_event_id"
    end

    create_table "event_change_histories", force: :cascade do |t|
      t.integer "event_id"
      t.integer "user_id"
      t.string "user_ip", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_event_change_histories_on_event_id"
      t.index ["user_id"], name: "index_event_change_histories_on_user_id"
    end

    create_table "event_links", force: :cascade do |t|
      t.integer "event_id"
      t.string "url"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_event_links_on_event_id"
    end

    create_table "event_performers", force: :cascade do |t|
      t.integer "event_id"
      t.string "performer"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["event_id"], name: "index_event_performers_on_event_id"
    end

    create_table "events", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "image_id"
      t.string "title"
      t.string "description"
      t.string "tel"
      t.string "email"
      t.datetime "datetime"
      t.string "place"
      t.datetime "general_sale"
      t.datetime "presale_start"
      t.datetime "presale_end"
    end

    create_table "followings", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "geinin_id"
      t.bigint "user_id"
      t.index ["geinin_id"], name: "index_followings_on_geinin_id"
      t.index ["user_id"], name: "index_followings_on_user_id"
    end

    create_table "geinin_member_tags", force: :cascade do |t|
      t.bigint "geinin_member_id_id"
      t.string "tag"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "geinin_id"
      t.index ["geinin_id"], name: "index_geinin_member_tags_on_geinin_id"
      t.index ["geinin_member_id_id"], name: "index_geinin_member_tags_on_geinin_member_id_id"
    end

    create_table "geinin_members", force: :cascade do |t|
      t.string "name"
      t.string "yomi"
      t.string "twitter_id"
      t.string "instagram_id"
      t.string "blog_url"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "geinin_id"
      t.index ["geinin_id"], name: "index_geinin_members_on_geinin_id"
    end

    create_table "geinin_tags", force: :cascade do |t|
      t.string "tag"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "geinin_id"
      t.index ["geinin_id"], name: "index_geinin_tags_on_geinin_id"
    end

    create_table "geinins", force: :cascade do |t|
      t.string "name"
      t.string "yomi"
      t.string "agency"
      t.integer "start_year"
      t.string "twitter_id"
      t.string "instagram_id"
      t.string "youtube_url"
      t.string "facebook_url"
      t.string "blog_url"
      t.string "official_profile_url"
      t.date "end_date"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "identities", force: :cascade do |t|
      t.string "provider"
      t.string "uid"
      t.bigint "user_id"
      t.string "name"
      t.string "description"
      t.string "image_url"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", unique: true
      t.index ["user_id"], name: "index_identities_on_user_id"
    end

    create_table "participates", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "event_id"
      t.integer "user_id"
      t.index ["event_id"], name: "index_participates_on_event_id"
      t.index ["user_id"], name: "index_participates_on_user_id"
    end

    create_table "pendings", force: :cascade do |t|
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "event_id"
      t.integer "user_id"
      t.index ["event_id"], name: "index_pendings_on_event_id"
      t.index ["user_id"], name: "index_pendings_on_user_id"
    end

    create_table "survey_answers", force: :cascade do |t|
      t.integer "rank"
      t.string "answer"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "survey_id"
      t.integer "votes"
      t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
    end

    create_table "surveys", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.date "start"
      t.date "end"
    end

    create_table "users", force: :cascade do |t|
      t.string "email"
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at"
      t.datetime "remember_created_at"
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "provider"
      t.string "uid"
      t.string "nickname"
      t.string "image_url"
      t.string "profile_image_id"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.string "name"
      t.string "url"
      t.string "description"
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    end

    add_foreign_key "event_categories", "events"
    add_foreign_key "followings", "geinins"
    add_foreign_key "followings", "users"
    add_foreign_key "geinin_member_tags", "geinins"
    add_foreign_key "geinin_members", "geinins"
    add_foreign_key "geinin_tags", "geinins"
    add_foreign_key "identities", "users"
    add_foreign_key "survey_answers", "surveys"
  end
end
