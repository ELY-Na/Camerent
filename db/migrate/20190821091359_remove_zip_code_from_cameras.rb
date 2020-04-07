class RemoveZipCodeFromCameras < ActiveRecord::Migration[5.2]
  def change
    remove_column :cameras, :zip_code, :integer
  end
end
