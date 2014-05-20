class CreateValidQualifications < ActiveRecord::Migration
  def change
    create_table :valid_qualifications do |t|
      t.integer :profile_id
      t.integer :qualification_id
      t.date :valid_from
      t.date :valid_to
      t.timestamps
    end
  end
end
