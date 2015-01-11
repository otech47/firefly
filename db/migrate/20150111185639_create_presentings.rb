class CreatePresentings < ActiveRecord::Migration
  def change
    create_table :presentings do |t|
      t.integer :team_id

      t.timestamps
    end
  end
end
