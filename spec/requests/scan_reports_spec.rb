require 'rails_helper'

RSpec.describe 'scan_reports' do
  describe 'POST /scan_reports' do
    it 'returns a 200' do
      post '/scan_reports'
      expect(response.code).to eq '200'
    end

    it 'creates a scan report' do
      expect { post '/scan_reports' }.to change(ScanReport, :count).from(0).to(1)
    end
  end
end
