class CreateBars < ActiveRecord::Migration[5.1]
  def change
    create_table :bars do |t|
      t.references :neighborhood, foreign_key: true
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :phone_number
      t.string :hours
      t.float :beer_price
      t.float :wine_price
      t.float :cocktails_price

      t.timestamps
    end
  end
end

# < ======= neighborhood_id, name, address, latitude, longitude, phone_number, hours, beer_price, wine_price, cocktails_price ======= >
