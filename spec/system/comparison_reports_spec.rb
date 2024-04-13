require 'rails_helper'

RSpec.describe 'Comparison Reports' do
  let(:scan_report) { ScanReport.create }

  describe 'index page' do
    it 'shows a list of comparison reports' do
      report = ComparisonReport.create(created_by: 'Alice Bob', scan_report:)
      visit '/'
      expect(page).to have_content('Alice Bob')
    end
  end

  describe 'creating a comparison report' do
    let!(:scan_result1) do
      FactoryBot.create :scan_result, name: 'ZA001A', detected_barcodes: 'ABC1', report: scan_report
    end
    let!(:scan_result2) do
      FactoryBot.create :scan_result, name: 'ZA002A', detected_barcodes: 'ABC9', report: scan_report
    end
    let!(:scan_result3) do
      FactoryBot.create :scan_result, name: 'ZA002A', detected_barcodes: 'ABC3', report: scan_report
    end

    it 'creates a comparison report' do
      visit '/'
      click_on 'New Comparison'
      choose(scan_report.created_at.to_s)
      click_on 'Generate'

      within('#discrepency-table') do
        expect(page).to have_content scan_result2.name
        expect(page).to have_content scan_result3.name
      end
    end
  end
end
