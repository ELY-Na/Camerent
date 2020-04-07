class AddPriceToCameras < ActiveRecord::Migration[5.2]
  def change
    add_column :cameras, :price, :float
  end
end
