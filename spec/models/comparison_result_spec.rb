require 'rails_helper'

RSpec.describe ComparisonResult do
  describe '#status' do
    it 'handles empty as expected' do
      subject = described_class.new(expected_barcodes: [], detected_barcodes: [])
      expect(subject.status).to eq :empty_expected
    end

    it 'handles empty but should have been occupied' do
      subject = described_class.new(expected_barcodes: ['ABC'], detected_barcodes: [])
      expect(subject.status).to eq :empty_unexpected
    end

    it 'handles occupied by expected items' do
      subject = described_class.new(expected_barcodes: ['ABC'], detected_barcodes: ['ABC'])
      expect(subject.status).to eq :occupied_expected
    end

    it 'handles occupied but should have been empty' do
      subject = described_class.new(expected_barcodes: [], detected_barcodes: ['ABC'])
      expect(subject.status).to eq :occupied_unexpected
    end

    it 'handles occupied by wrong items' do
      subject = described_class.new(expected_barcodes: ['ABC'], detected_barcodes: ['XYZ'])
      expect(subject.status).to eq :occupied_incorrect
    end
  end
end
