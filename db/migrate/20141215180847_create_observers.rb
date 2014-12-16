class CreateObservers < ActiveRecord::Migration
  def change
    create_table :observers do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
