class CreateQualificationsTable < ActiveRecord::Migration
  def change
    create_table :qualifications do |t|
      t.string :name
      t.string :description
      t.string :abbreviation
      t.timestamps
    end
  end

end
