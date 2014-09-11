class AddDefaultHoursOfWorkToEvents < ActiveRecord::Migration
  def change
    add_column :events, :default_hours_of_work, :float
  end
end
