class RemoveGroups < ActiveRecord::Migration
  def up
    drop_table :groups

    remove_column :users, :group_id
    add_column :users, :group, :integer

    remove_column :articles, :group_id
    add_column :articles, :group, :integer
  end

  def down
    remove_column :articles, :group
    add_column :articles, :group_id, :integer

    remove_column :users, :group
    add_column :users, :group_id, :integer

    create_table :groups do |t|

	  t.string :ident
      t.string :name

      t.timestamps
    end
  end
end
