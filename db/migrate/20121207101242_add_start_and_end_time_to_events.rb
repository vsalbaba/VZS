class AddStartAndEndTimeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :start_datetime, :datetime
    add_column :events, :end_datetime, :datetime
    remove_column :events, :date
    add_column :events, :place, :string
    add_column :events, :event_type, :string
    add_column :events, :link, :string
  end
end
