class CreateSubscriptions < ActiveRecord::Migration
  def up
    create_table :subscriptions do |t|
      t.belongs_to :show
      t.belongs_to :user
      t.boolean :subscribed
      t.boolean :wants_payed
      t.timestamps
    end

    add_index :subscriptions, :show_id
    add_index :subscriptions, :user_id
  end

  def down
    drop_table :subscriptions
  end
end
