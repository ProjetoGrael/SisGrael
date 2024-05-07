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

ActiveRecord::Schema.define(version: 20210511205528) do

  create_table "accounts", force: :cascade do |t|
    t.string "number"
    t.string "agency"
    t.string "bank"
    t.decimal "current_value", precision: 20, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "assistance_programs", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "captations", force: :cascade do |t|
    t.string "source"
    t.decimal "value", precision: 20, scale: 2
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_captations_on_project_id"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "state_id"
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "classroom_subjects", force: :cascade do |t|
    t.integer "classroom_id"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "teacher_id"
    t.time "start_time"
    t.time "finish_time"
    t.boolean "lesson_on_monday", default: false
    t.boolean "lesson_on_tuesday", default: false
    t.boolean "lesson_on_wednesday", default: false
    t.boolean "lesson_on_thursday", default: false
    t.boolean "lesson_on_friday", default: false
    t.index ["classroom_id"], name: "index_classroom_subjects_on_classroom_id"
    t.index ["subject_id"], name: "index_classroom_subjects_on_subject_id"
    t.index ["teacher_id"], name: "index_classroom_subjects_on_teacher_id"
  end

  create_table "classrooms", force: :cascade do |t|
    t.string "fantasy_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_year_id"
    t.string "opinion"
    t.integer "main_id"
    t.index ["school_year_id"], name: "index_classrooms_on_school_year_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "name"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "student_id"
    t.index ["student_id"], name: "index_expenses_on_student_id"
  end

  create_table "family_members", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.integer "scholarity"
    t.string "occupation"
    t.decimal "income"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "service_sheet_id"
    t.index ["service_sheet_id"], name: "index_family_members_on_service_sheet_id"
    t.index ["student_id"], name: "index_family_members_on_student_id"
  end

  create_table "free_times", force: :cascade do |t|
    t.date "day"
    t.time "start_at"
    t.time "finish_at"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_free_times_on_user_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.string "name"
    t.date "day"
    t.integer "school_year_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_year_id"], name: "index_holidays_on_school_year_id"
  end

  create_table "inscriptions", force: :cascade do |t|
    t.integer "student_id"
    t.integer "classroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "situation", default: 0
    t.string "counsel_opinion"
    t.integer "subject_level_id"
    t.integer "subject_id"
    t.boolean "active", default: true
    t.date "renewable_date"
    t.string "student_status"
    t.date "modification_day_status"
    t.boolean "renewed_bool", default: false
    t.index ["classroom_id"], name: "index_inscriptions_on_classroom_id"
    t.index ["student_id"], name: "index_inscriptions_on_student_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.integer "kind"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "interviews", force: :cascade do |t|
    t.integer "student_id"
    t.integer "user_id"
    t.string "reason"
    t.date "date_of_interview"
    t.time "time_of_interview"
    t.integer "kind"
    t.string "student_name"
    t.index ["student_id"], name: "index_interviews_on_student_id"
    t.index ["user_id"], name: "index_interviews_on_user_id"
  end

  create_table "labor_markets", force: :cascade do |t|
    t.integer "year"
    t.integer "student_id"
    t.date "date_closure"
    t.date "date_start"
    t.date "date_exit"
    t.string "company"
    t.string "company_address"
    t.string "student_occupation_area"
    t.string "student_office"
    t.string "contact_name"
    t.string "contact_office"
    t.string "contact_email"
    t.string "company_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hiring_kind"
    t.index ["student_id"], name: "index_labor_markets_on_student_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.text "notes"
    t.text "observations"
    t.date "day"
    t.integer "classroom_subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "done", default: false
    t.integer "ordenation"
    t.boolean "holiday", default: false
    t.index ["classroom_subject_id"], name: "index_lessons_on_classroom_subject_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "city_id"
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.integer "student_id"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "school_year_id"
    t.index ["school_year_id"], name: "index_occurrences_on_school_year_id"
    t.index ["student_id"], name: "index_occurrences_on_student_id"
    t.index ["user_id"], name: "index_occurrences_on_user_id"
  end

  create_table "presences", force: :cascade do |t|
    t.integer "situation", default: 0
    t.integer "lesson_id"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "participation"
    t.index ["lesson_id"], name: "index_presences_on_lesson_id"
    t.index ["student_id"], name: "index_presences_on_student_id"
  end

  create_table "program_aids", force: :cascade do |t|
    t.integer "student_id"
    t.integer "assistance_program_id"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assistance_program_id"], name: "index_program_aids_on_assistance_program_id"
    t.index ["student_id"], name: "index_program_aids_on_student_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "total_value", precision: 20, scale: 2, default: "0.0"
    t.decimal "current_value", precision: 20, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "registration_numbers", force: :cascade do |t|
    t.string "year"
    t.string "semester"
    t.integer "number_students"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rubric_items", force: :cascade do |t|
    t.integer "numeration"
    t.string "description"
    t.decimal "value", precision: 20, scale: 2
    t.integer "rubric_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rubric_id"], name: "index_rubric_items_on_rubric_id"
  end

  create_table "rubrics", force: :cascade do |t|
    t.integer "numeration"
    t.string "description"
    t.decimal "value", precision: 20, scale: 2
    t.integer "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "current_value", precision: 20, scale: 2
    t.index ["project_id"], name: "index_rubrics_on_project_id"
  end

  create_table "school_years", force: :cascade do |t|
    t.string "name"
    t.date "start"
    t.date "final"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.integer "capacity", default: 0
    t.string "background_image"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.integer "number_students", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_sheets", force: :cascade do |t|
    t.integer "student_id"
    t.string "dwell_time_address"
    t.integer "marital_status"
    t.boolean "disabled_person"
    t.boolean "has_documentation"
    t.string "father"
    t.string "mother"
    t.integer "working_situation"
    t.text "working_situation_other"
    t.boolean "receives_benefit"
    t.text "receives_benefit_wich"
    t.string "dwell_time_city"
    t.text "previously_resided_city"
    t.integer "residence_status"
    t.text "residence_status_text"
    t.integer "kind_of_residence"
    t.text "kind_of_residence_text"
    t.integer "room_number"
    t.boolean "medication"
    t.text "medication_text"
    t.boolean "psychiatric_treatment"
    t.text "psychiatric_treatment_where"
    t.boolean "deficiency_in_family"
    t.text "deficiency_in_family_text"
    t.text "deficiency_in_family_who"
    t.text "health_more_info"
    t.boolean "protective_measures"
    t.text "protective_measures_text"
    t.boolean "socio_educational_measure"
    t.text "socio_educational_measure_text"
    t.text "socio_educational_measure_when"
    t.text "notes"
    t.text "referrals"
    t.string "responsible_technician"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current_working"
    t.text "disabled_person_text"
    t.text "has_documentation_text"
    t.decimal "salary"
    t.decimal "per_capta_income"
    t.decimal "total_income"
    t.string "student_name"
    t.boolean "psychological_support"
    t.text "psychological_support_info"
    t.index ["student_id"], name: "index_service_sheets_on_student_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_classroom_subjects", force: :cascade do |t|
    t.integer "inscription_id"
    t.integer "classroom_subject_id"
    t.boolean "show", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classroom_subject_id"], name: "index_student_classroom_subjects_on_classroom_subject_id"
    t.index ["inscription_id"], name: "index_student_classroom_subjects_on_inscription_id"
  end

  create_table "students", force: :cascade do |t|
    t.integer "city_id"
    t.integer "neighborhood_id"
    t.integer "school_id"
    t.integer "state_id"
    t.string "year"
    t.string "semester"
    t.string "photo"
    t.string "name"
    t.date "birthdate"
    t.integer "sex"
    t.integer "ethnicity"
    t.string "nationality"
    t.string "naturalness"
    t.string "rg"
    t.string "issuing_agency"
    t.date "issuing_date"
    t.string "cpf"
    t.string "address"
    t.string "cep"
    t.string "sub_neighborhood"
    t.string "email"
    t.string "phone"
    t.string "mobile_phone"
    t.integer "project_indication"
    t.text "project_indication_description"
    t.text "medication"
    t.integer "school_shift"
    t.integer "grade"
    t.string "father_name"
    t.string "father_cpf"
    t.string "father_email"
    t.string "father_phone"
    t.string "mother_name"
    t.string "mother_cpf"
    t.string "mother_email"
    t.string "mother_phone"
    t.string "responsible_name"
    t.string "responsible_cpf"
    t.string "responsible_email"
    t.string "responsible_phone"
    t.integer "number_residents"
    t.decimal "family_income"
    t.string "nis"
    t.text "annotations"
    t.boolean "working"
    t.string "company"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "rg_missing"
    t.boolean "cpf_missing"
    t.boolean "responsible_rg_missing"
    t.boolean "responsible_cpf_missing"
    t.boolean "address_proof_missing"
    t.boolean "term_signed_missing"
    t.boolean "school_declaration_missing"
    t.boolean "medical_certificate_missing"
    t.boolean "birth_certificate_missing"
    t.boolean "historic_missing"
    t.string "registration_number"
    t.integer "status", default: 0
    t.integer "completed", default: 1
    t.integer "specific_school_level"
    t.string "medical_report"
    t.string "behavior"
    t.string "difficulties"
    t.string "kinship"
    t.boolean "father_responsible", default: false
    t.boolean "mother_responsible", default: false
    t.boolean "student_responsible", default: false
    t.boolean "other_relative_responsible", default: true
    t.boolean "photo_and_video_permited"
    t.index ["city_id"], name: "index_students_on_city_id"
    t.index ["neighborhood_id"], name: "index_students_on_neighborhood_id"
    t.index ["school_id"], name: "index_students_on_school_id"
    t.index ["state_id"], name: "index_students_on_state_id"
  end

  create_table "subject_histories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "classroom_subject_id"
    t.decimal "presence"
    t.integer "justified_absences"
    t.decimal "partial_counsel"
    t.decimal "final_counsel"
    t.integer "subject_level_id"
    t.integer "inscription_id"
    t.boolean "done"
    t.datetime "date_resolved_absence"
    t.boolean "show", default: true
    t.index ["classroom_subject_id"], name: "index_subject_histories_on_classroom_subject_id"
    t.index ["inscription_id"], name: "index_subject_histories_on_inscription_id"
    t.index ["subject_level_id"], name: "index_subject_histories_on_subject_level_id"
  end

  create_table "subject_levels", force: :cascade do |t|
    t.string "name"
    t.integer "order"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: true
    t.index ["subject_id"], name: "index_subject_levels_on_subject_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.boolean "active", default: true
    t.string "name"
    t.text "planning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "leveled", default: false
    t.string "syllabus"
    t.integer "workload"
    t.boolean "professionalized"
    t.boolean "sport"
    t.boolean "environmental", default: false
  end

  create_table "teacher_skills", force: :cascade do |t|
    t.integer "teacher_id"
    t.integer "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_teacher_skills_on_subject_id"
    t.index ["teacher_id"], name: "index_teacher_skills_on_teacher_id"
  end

  create_table "teachers", force: :cascade do |t|
    t.boolean "active", default: true
    t.date "birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex"
    t.integer "ethnicity"
    t.string "nationality"
    t.string "naturalness"
    t.string "rg"
    t.string "issuing_agency"
    t.date "issuing_date"
    t.string "cpf"
    t.string "address"
    t.string "cep"
    t.string "phone"
    t.string "mobile_phone"
    t.integer "user_id"
    t.index ["user_id"], name: "index_teachers_on_user_id"
  end

  create_table "transaction_categories", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "value", precision: 20, scale: 2, default: "0.0"
    t.text "description"
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "transaction_category_id"
    t.integer "payer_id"
    t.integer "receiver_id"
    t.date "transaction_date"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["payer_id"], name: "index_transactions_on_payer_id"
    t.index ["receiver_id"], name: "index_transactions_on_receiver_id"
    t.index ["transaction_category_id"], name: "index_transactions_on_transaction_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "banned?", default: false
    t.string "signature"
    t.boolean "super_admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vocational_interviews", force: :cascade do |t|
    t.string "enrolled_in_the_course"
    t.string "social_name"
    t.string "phone"
    t.string "mobile"
    t.integer "last_attended_educational_institution"
    t.boolean "repetition"
    t.text "special_needs"
    t.text "live_with"
    t.string "live_with_other"
    t.text "housing_condition"
    t.integer "urban_infrastructure"
    t.integer "motivation"
    t.boolean "already_attended"
    t.text "already_attended_when"
    t.integer "already_attended_which"
    t.text "already_attended_which_other"
    t.integer "already_attended_difference"
    t.text "already_attended_difference_other"
    t.boolean "nautical_experience"
    t.text "nautical_experience_text"
    t.boolean "already_attended_to_other"
    t.text "already_attended_to_other_text"
    t.integer "project_access"
    t.text "project_access_other"
    t.integer "number_transport"
    t.boolean "have_income"
    t.boolean "work"
    t.text "work_wich"
    t.boolean "father_works"
    t.boolean "mother_works"
    t.boolean "step_father_works"
    t.boolean "step_mother_works"
    t.boolean "brothers_works"
    t.boolean "grandparents_works"
    t.boolean "other_works"
    t.text "workers_in_family_other"
    t.text "working_time"
    t.boolean "home_computer_use"
    t.boolean "work_computer_use"
    t.boolean "school_computer_use"
    t.boolean "lan_house_computer_use"
    t.boolean "friend_house_computer_use"
    t.boolean "computer_use_other"
    t.text "computer_use_other_text"
    t.boolean "microsoft_office_knowledge"
    t.boolean "internet_surfer"
    t.boolean "social_networks"
    t.text "social_networks_text"
    t.integer "family_life"
    t.boolean "family_lunch"
    t.boolean "family_talking_about_life"
    t.boolean "family_talking_about_work"
    t.boolean "recreational_activities"
    t.boolean "family_weekend"
    t.boolean "reveal_about_family"
    t.text "reveal_about_family_text"
    t.boolean "artistic_activity"
    t.boolean "religious_activity"
    t.boolean "sport_activity"
    t.boolean "family_activity"
    t.boolean "comunity_activity"
    t.boolean "other_activity"
    t.boolean "about_future_with_family"
    t.text "about_future_with_family_who"
    t.text "completed_by"
    t.text "concluding_remarks"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "other_motivation"
    t.text "recreation_doing"
    t.integer "ethnicity"
    t.integer "amount_repetitions"
    t.string "student_name"
    t.index ["student_id"], name: "index_vocational_interviews_on_student_id"
  end

end
