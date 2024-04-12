# frozen_string_literal: true

class CreateScanResults < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_results do |t|
      t.string :name
      t.boolean :scanned, null: false, default: false
      t.boolean :occupied, null: false, default: false
      t.string :detected_barcodes, array: true
      t.belongs_to :scan_report

      t.timestamps
    end
  end
end
