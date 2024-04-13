# frozen_string_literal: true

class ComparisonReport < ApplicationRecord
  belongs_to :scan_report
  has_many :results, class_name: 'ComparisonResult', dependent: :destroy

  def generate(comparison_records)
    comparison_records.each do |record|
      related_scan = scan_result(record['LOCATION'])
      results.build(comparison_result_attributes(record, related_scan))
    end

    save
  end

  private

  def scan_result(location_name)
    scan_report.results.find_by(name: location_name)
  end

  def comparison_result_attributes(comparison_record, related_scan)
    {
      name: comparison_record['LOCATION'],
      expected_barcodes: [comparison_record['ITEM']],
      detected_barcodes: related_scan.detected_barcodes,
      discrepencies: discrepencies_xor(related_scan.detected_barcodes, [comparison_record['ITEM']]),
      report: self
    }
  end

  def discrepencies_xor(detected, expected)
    xor = (detected - expected) + (expected - detected)
    xor.compact_blank
  end
end
