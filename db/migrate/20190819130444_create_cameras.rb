class CreateCameras < ActiveRecord::Migration[5.2]
  def change
    create_table :cameras do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zip_code
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
