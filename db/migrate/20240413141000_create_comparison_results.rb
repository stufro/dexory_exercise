# frozen_string_literal: true

class CreateComparisonResults < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_results do |t|
      t.string :name
      t.string :expected_barcodes, array: true, default: []
      t.string :detected_barcodes, array: true, default: []
      t.string :discrepancies, array: true, default: []
      t.belongs_to :comparison_report

      t.timestamps
    end
  end
end
