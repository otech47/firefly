class AddCheckedInToObservers < ActiveRecord::Migration
  def change
    add_column :observers, :checked_in, :boolean, null: false, default: false
  end
end
