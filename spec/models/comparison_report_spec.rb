require 'rails_helper'

RSpec.describe ComparisonReport do
  subject { described_class.new(scan_report:) }

  let(:scan_report) { ScanReport.create }
  let!(:scan_result1) do
    FactoryBot.create :scan_result, name: 'ZA001A', detected_barcodes: ['ABC1'], report: scan_report
  end
  let(:comparison_data) do
    [{ 'LOCATION' => 'ZA001A', 'ITEM' => 'ABC1' }]
  end

  describe '#generate' do
    it 'saves a comparison result for each scan result' do
      subject.generate(comparison_data)
      expect(ComparisonResult.find_by!(name: 'ZA001A')).to have_attributes(
        expected_barcodes: ['ABC1'],
        detected_barcodes: ['ABC1'],
        discrepencies: []
      )
    end
  end
end
