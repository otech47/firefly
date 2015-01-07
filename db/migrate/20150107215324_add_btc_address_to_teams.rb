class AddBtcAddressToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :btc_address, :string
  end
end
