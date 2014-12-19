class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :repo
      t.string :video
      t.integer :admin

      t.timestamps
    end
  end
end
