class AddBtcAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :btc_address, :string
  end
end
