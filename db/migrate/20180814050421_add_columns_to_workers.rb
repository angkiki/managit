class AddColumnsToWorkers < ActiveRecord::Migration[5.2]
  def change
    add_column :workers, :p256dh, :string
    add_column :workers, :auth, :string
  end
end
