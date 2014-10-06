class AddParticipationTypeToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :participation_type, :string, :default => "yes"
    Participation.all.each do |e|
      e.participation_type="yes"
    end
  end
end
