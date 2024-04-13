# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'comparison_reports' do
  describe 'POST /comparison_reports' do
    subject do
      post '/comparison_reports', params: { comparison_report: { scan_report_id: scan_report.id, comparison_file: } }
    end

    let(:comparison_file) { fixture_file_upload(Rails.root.join('spec/fixtures/comparison_input.csv')) }
    let(:scan_report) { ScanReport.create }

    it 'saves a new comparison report' do
      expect { subject }.to change { ComparisonReport.count }.from(0).to(1)
    end

    it 'redirects to the show page' do
      subject
      expect(response).to redirect_to comparison_report_path(ComparisonReport.first)
    end

    context 'when the scan_report does not exist' do
      subject { post '/comparison_reports', params: { comparison_report: { scan_report_id: 999, comparison_file: } } }

      it 'renders the new page' do
        subject
        expect(response).to render_template :new
      end
    end
  end
end
