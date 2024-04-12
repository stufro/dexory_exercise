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
    before do
      FactoryBot.create_list :scan_result, 3, report: scan_report
    end

    it 'creates a comparison report' do
      visit '/'
      click_on 'New Comparison'
      choose(scan_report.created_at.to_s)
      click_on 'Generate'

      expect(ComparisonReport.count).to eq 1
      expect(ComparisonReport.first.scan_report.id).to eq scan_report.id
    end
  end
end
