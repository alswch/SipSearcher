class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true
      t.integer :beer_price
      t.integer :wine_price
      t.integer :cocktails_price
      t.integer :rating
      t.text :comment

      t.timestamps
    end
  end
end

# < ======= user_id, beer_price, wine_price, cocktails_price, rating, comment ======= >
