class RemoveHoursFromBars < ActiveRecord::Migration[5.1]
  def change
    remove_column :bars, :hours, :string
  end
end
