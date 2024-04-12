class CreateScanResults < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_results do |t|
      t.string :name
      t.boolean :scanned
      t.boolean :occupied
      t.string :detected_barcodes, array: true
      t.belongs_to :scan_report

      t.timestamps
    end
  end
end
