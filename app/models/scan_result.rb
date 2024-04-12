class ScanResult < ApplicationRecord
  belongs_to :report, class_name: 'ScanReport', foreign_key: 'scan_report_id'
end
