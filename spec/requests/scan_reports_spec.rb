require 'rails_helper'

RSpec.describe 'scan_reports' do
  describe 'POST /scan_reports' do
    subject { post '/scan_reports', params: [scan_result].to_json, headers: { 'Content-Type' => 'application/json' } }

    let(:scan_result) do
      { name: 'ZA001A', scanned: true, occupied: true, detected_barcodes: ['DX9850004338'] }
    end

    it 'returns a 200' do
      subject
      expect(response.code).to eq '200'
    end

    it 'creates a scan report' do
      expect { subject }.to change(ScanReport, :count).from(0).to(1)
    end

    it 'creates the scan results for the report' do
      subject
      expect(ScanReport.first.results.first).to have_attributes(scan_result)
    end

    it 'returns a success response body' do
      subject
      expect(response.body).to eq({ results_imported: 1 }.to_json)
    end

    context 'when given invalid JSON' do
      subject { post '/scan_reports', params: '{foo', headers: { 'Content-Type' => 'application/json' } }

      it 'returns a 400' do
        subject
        expect(response.code).to eq '400'
      end

      it 'returns an error response body' do
        subject
        expect(response.body).to eq '{"error":"unexpected token at \'{foo\'"}'
      end
    end
  end
end
