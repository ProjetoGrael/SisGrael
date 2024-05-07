class CreateVocationalInterviews < ActiveRecord::Migration[5.1]
  def change
    create_table :vocational_interviews do |t|
      t.string :enrolled_in_the_course
      t.string :social_name
      t.string :phone
      t.string :mobile
      t.integer :last_attended_educational_institution
      t.boolean :repetition
      t.text :special_needs
      t.integer :live_with
      t.string :live_with_other
      t.integer :housing_condition
      t.integer :urban_infrastructure
      t.integer :motivation
      t.boolean :already_attended
      t.text :already_attended_when
      t.integer :already_attended_which
      t.text :already_attended_which_other
      t.integer :already_attended_difference
      t.text :already_attended_difference_other
      t.boolean :nautical_experience
      t.text :nautical_experience_text
      t.boolean :already_attended_to_other
      t.text :already_attended_to_other_text
      t.integer :project_access
      t.text :project_access_other
      t.integer :number_transport
      t.boolean :have_income
      t.boolean :work
      t.text :work_wich
      t.boolean :father_works
      t.boolean :mother_works
      t.boolean :step_father_works
      t.boolean :step_mother_works
      t.boolean :brothers_works
      t.boolean :grandparents_works
      t.boolean :other_works
      t.text :workers_in_family_other
      t.text :working_time
      t.boolean :home_computer_use
      t.boolean :work_computer_use
      t.boolean :school_computer_use
      t.boolean :lan_house_computer_use
      t.boolean :friend_house_computer_use
      t.boolean :computer_use_other
      t.text :computer_use_other_text
      t.boolean :microsoft_office_knowledge
      t.boolean :internet_surfer
      t.boolean :social_networks
      t.text :social_networks_text
      t.integer :family_life
      t.boolean :family_lunch
      t.boolean :family_talking_about_life
      t.boolean :family_talking_about_work
      t.boolean :recreational_activities
      t.boolean :family_weekend
      t.boolean :reveal_about_family
      t.text :reveal_about_family_text
      t.boolean :artistic_activity
      t.boolean :religious_activity
      t.boolean :sport_activity
      t.boolean :family_activity
      t.boolean :comunity_activity
      t.boolean :other_activity
      t.boolean :about_future_with_family
      t.text :about_future_with_family_who
      t.text :completed_by
      t.text :concluding_remarks
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
