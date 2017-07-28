class AddColumnsToBars < ActiveRecord::Migration[5.1]
  def change
    add_column :bars, :start_day, :string
    add_column :bars, :end_day, :string
    add_column :bars, :start_hour, :time
    add_column :bars, :end_hour, :time
  end
end
