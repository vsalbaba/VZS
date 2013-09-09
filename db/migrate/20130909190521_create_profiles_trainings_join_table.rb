class CreateProfilesTrainingsJoinTable < ActiveRecord::Migration
  def change
    create_table :profiles_trainings do |t|
      t.integer :profile_id
      t.integer :training_id
    end
  end
end
