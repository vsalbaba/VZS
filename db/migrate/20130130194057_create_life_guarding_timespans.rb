class CreateLifeGuardingTimespans < ActiveRecord::Migration
  def change
    create_table :life_guarding_timespans do |t|
      t.date :from
      t.date :to

      t.timestamps
    end
  end
end
