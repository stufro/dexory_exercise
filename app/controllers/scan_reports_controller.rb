class ScanReportsController < ApplicationController
  def create
    ScanReport.create
    render json: '{}'
  end
end
