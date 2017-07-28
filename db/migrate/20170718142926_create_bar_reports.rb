class CreateBarReports < ActiveRecord::Migration[5.1]
  def change
    create_table :bar_reports do |t|
      t.references :bar, foreign_key: true
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end

# < ======= bar_id, report_id ======= >
