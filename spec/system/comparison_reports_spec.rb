# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comparison Reports' do
  let(:scan_report) { ScanReport.create }

  describe 'index page' do
    it 'shows a list of comparison reports' do
      ComparisonReport.create(created_by: 'Alice Bob', scan_report:)
      visit '/'
      expect(page).to have_content('Alice Bob')
    end
  end

  describe 'creating a comparison report' do
    let!(:scan_result) do
      FactoryBot.create :scan_result, name: 'ZA001A', detected_barcodes: ['ABC1'], report: scan_report
    end
    let!(:scan_result_incorrect_barcode) do
      FactoryBot.create :scan_result, name: 'ZA002A', detected_barcodes: ['ABC9'], report: scan_report
    end
    let!(:scan_result_unexpected_barcode) do
      FactoryBot.create :scan_result, name: 'ZA003A', detected_barcodes: ['ABC3'], report: scan_report
    end

    it 'creates a comparison report' do
      visit '/'
      click_on 'New Comparison'
      choose(scan_report.created_at.to_s)
      attach_file('comparison_report[comparison_file]', Rails.root.join('spec/fixtures/comparison_input.csv'))
      click_on 'Generate'

      within('#discrepancy-table') do
        expect(page).to have_content scan_result_incorrect_barcode.name
        expect(page).to have_content scan_result_unexpected_barcode.name
      end

      expect(page).to have_content 'Occupied with incorrect item'
      expect(page).to have_content 'Occupied (Expected to be empty)'
      expect(page).to have_content 'Occupied as expected'
    end
  end
end
