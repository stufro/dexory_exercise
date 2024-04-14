# frozen_string_literal: true

class ComparisonReport < ApplicationRecord
  belongs_to :scan_report
  has_many :results, class_name: 'ComparisonResult', dependent: :destroy

  def generate(comparison_records)
    return unless scan_report

    comparison_records.each do |record|
      related_scan = scan_result(record['LOCATION'])
      results.build(comparison_result_attributes(record, related_scan))
    end

    save
  end

  def discrepancies
    results.where('cardinality(discrepancies) > 0')
  end

  def non_discrepancies
    results.where('cardinality(discrepancies) = 0')
  end

  private

  def scan_result(location_name)
    scan_report.results.find_by(name: location_name)
  end

  def comparison_result_attributes(comparison_record, related_scan)
    {
      name: comparison_record['LOCATION'],
      expected_barcodes: [comparison_record['ITEM']].compact,
      detected_barcodes: related_scan&.detected_barcodes,
      discrepancies: discrepancies_xor(related_scan&.detected_barcodes, [comparison_record['ITEM']]),
      report: self
    }
  end

  def discrepancies_xor(detected, expected)
    return [] if detected.nil?

    xor = (detected - expected) + (expected - detected)
    xor.compact_blank
  end
end
