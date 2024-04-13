# frozen_string_literal: true

require 'csv'

class ComparisonReportsController < ApplicationController
  def index
    @reports = ComparisonReport.all
  end

  def show
    @report = ComparisonReport.find(params[:id])
  end

  def new
    @report = ComparisonReport.new
  end

  def create
    @report = ComparisonReport.new(comparison_report_params)
    comparison_data = CSV.parse(params[:comparison_report][:comparison_file].tempfile, headers: true).map(&:to_h)
    if @report.generate(comparison_data)
      redirect_to comparison_report_path(@report)
    else
      render :new
    end
  end

  private

  def comparison_report_params
    params.require(:comparison_report).permit(:scan_report_id)
  end
end
