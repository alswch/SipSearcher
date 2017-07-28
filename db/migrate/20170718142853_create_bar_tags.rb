class CreateBarTags < ActiveRecord::Migration[5.1]
  def change
    create_table :bar_tags do |t|
      t.references :bar, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end

# < ======= bar_id, tag_id ======= >
