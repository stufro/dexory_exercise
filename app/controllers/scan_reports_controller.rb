class ScanReportsController < ApplicationController
  def create
    report = ScanReport.create
    report.results.create!(JSON.parse(request.body.read))
    render json: '{}'
  end
end
