class AddPhotoToBars < ActiveRecord::Migration[5.1]
  def change
    add_reference :bars, :photo, foreign_key: true
  end
end
