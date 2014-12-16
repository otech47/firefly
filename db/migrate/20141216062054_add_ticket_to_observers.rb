class AddTicketToObservers < ActiveRecord::Migration
  def change
    add_column :observers, :ticket, :string
  end
end
