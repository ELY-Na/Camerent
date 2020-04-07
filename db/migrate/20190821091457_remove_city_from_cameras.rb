class RemoveCityFromCameras < ActiveRecord::Migration[5.2]
  def change
    remove_column :cameras, :city, :string
  end
end
