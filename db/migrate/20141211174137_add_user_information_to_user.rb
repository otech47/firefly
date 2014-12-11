class AddUserInformationToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :repo, :string
  end
end
