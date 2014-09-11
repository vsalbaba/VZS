class AddResponsiblePersonIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :responsible_person_id, :integer
  end
end
