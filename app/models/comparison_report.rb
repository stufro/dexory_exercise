class ComparisonReport < ApplicationRecord
  belongs_to :scan_report
  has_many :results, class_name: 'ComparisonResult', dependent: :destroy

  def generate(comparison_records)
    comparison_records.each do |record|
      related_scan = scan_result(record['LOCATION'])
      results.build(
        name: record['LOCATION'],
        expected_barcodes: [record['ITEM']],
        detected_barcodes: related_scan.detected_barcodes,
        discrepencies: [],
        report: self
      )
    end

    save
  end

  private

  def scan_result(location_name)
    scan_report.results.find_by(name: location_name)
  end
end
