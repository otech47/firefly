class AddProjectNameToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :project_name, :string
  end
end
