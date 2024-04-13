class ComparisonReportsController < ApplicationController
  def index
    @reports = ComparisonReport.all
  end

  def new
    @report = ComparisonReport.new
  end

  def create
    @report = ComparisonReport.new(comparison_report_params)
    if @report.generate
      redirect_to comparison_reports_path
    else
      render :new
    end
  end

  private

  def comparison_report_params
    params.require(:comparison_report).permit(:scan_report_id)
  end
end
