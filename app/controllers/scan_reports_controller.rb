# frozen_string_literal: true

class ScanReportsController < ActionController::API
  def create
    report = ScanReport.create
    results = report.results.create(JSON.parse(request.body.read))
    render json: { results_imported: results.count }
  rescue JSON::ParserError => e
    render json: { error: e.message }, status: :bad_request
  end
end
