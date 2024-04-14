# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ComparisonReport do
  subject { described_class.new(scan_report:) }

  let(:scan_report) { ScanReport.create }
  let(:comparison_data) do
    [{ 'LOCATION' => 'ZA001A', 'ITEM' => 'ABC1' }]
  end
  let(:detected_barcodes) { ['ABC1'] }

  before do
    FactoryBot.create :scan_result, name: 'ZA001A', detected_barcodes:, report: scan_report
  end

  describe '#generate' do
    it 'saves a comparison result for each scan result' do
      subject.generate(comparison_data)
      expect(ComparisonResult.find_by!(name: 'ZA001A')).to have_attributes(
        expected_barcodes: ['ABC1'],
        detected_barcodes: ['ABC1'],
        discrepancies: []
      )
    end

    it 'returns true' do
      expect(subject.generate(comparison_data)).to be true
    end

    context 'when there is an unexpected barcode detected' do
      let(:comparison_data) do
        [{ 'LOCATION' => 'ZA001A', 'ITEM' => '' }]
      end

      it 'includes the barcode in the discrepancies field' do
        subject.generate(comparison_data)
        expect(ComparisonResult.find_by!(name: 'ZA001A').discrepancies).to match_array(
          ['ABC1']
        )
      end
    end

    context 'when an expected barcode is missing' do
      let(:comparison_data) do
        [{ 'LOCATION' => 'ZA001A', 'ITEM' => 'ABC1' }]
      end
      let(:detected_barcodes) { [] }

      it 'includes the barcode in the discrepancies field' do
        subject.generate(comparison_data)
        expect(ComparisonResult.find_by!(name: 'ZA001A').discrepancies).to match_array(
          ['ABC1']
        )
      end
    end

    context 'when there is no scan_report' do
      subject { described_class.new(scan_report: nil) }

      it 'returns falsey' do
        expect(subject.generate(comparison_data)).to be_falsey
      end
    end
  end

  describe '#discrepancies' do
    it 'returns comparison results with more than 0 discrepancies' do
      subject = described_class.create(scan_report:)
      discrepant_result = ComparisonResult.create(report: subject, discrepancies: ['Foo'])
      ComparisonResult.create(report: subject, discrepancies: [])

      expect(subject.discrepancies).to eq [discrepant_result]
    end
  end

  describe '#non_discrepancies' do
    it 'returns comparison results with more than 0 discrepancies' do
      subject = described_class.create(scan_report:)
      ok_result = ComparisonResult.create(report: subject, discrepancies: [])
      ComparisonResult.create(report: subject, discrepancies: ['Foo'])

      expect(subject.non_discrepancies).to eq [ok_result]
    end
  end
end
