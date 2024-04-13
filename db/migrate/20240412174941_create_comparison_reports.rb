# frozen_string_literal: true

class CreateComparisonReports < ActiveRecord::Migration[7.1]
  def change
    create_table :comparison_reports do |t|
      t.string :created_by
      t.belongs_to :scan_report

      t.timestamps
    end
  end
end
