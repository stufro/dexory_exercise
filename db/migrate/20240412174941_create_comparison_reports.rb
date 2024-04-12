class CreateComparisonReports < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_reports do |t|
      t.string :created_by

      t.timestamps
    end
  end
end
