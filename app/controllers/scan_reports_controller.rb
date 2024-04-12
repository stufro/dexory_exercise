class ScanReportsController < ApplicationController
  def create
    report = ScanReport.create
    results = report.results.create!(JSON.parse(request.body.read))
    render json: { results_imported: results.count }
  end
end
