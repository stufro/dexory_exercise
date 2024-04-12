class ComparisonReportsController < ApplicationController
  def index
    @reports = ComparisonReport.all
  end
end
