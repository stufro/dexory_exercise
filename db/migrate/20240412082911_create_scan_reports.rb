# frozen_string_literal: true

class CreateScanReports < ActiveRecord::Migration[7.1]
  def change
    create_table :scan_reports, &:timestamps
  end
end
