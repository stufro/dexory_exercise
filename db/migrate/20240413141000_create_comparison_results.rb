class CreateComparisonResults < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_results do |t|
      t.string :name
      t.string :expected_barcodes, array: true
      t.string :detected_barcodes, array: true
      t.string :discrepencies, array: true
      t.belongs_to :comparison_report

      t.timestamps
    end
  end
end
