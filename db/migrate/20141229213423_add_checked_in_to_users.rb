class AddCheckedInToUsers < ActiveRecord::Migration
  def change
    add_column :users, :checked_in, :boolean, null: false, default: false
  end
end
