# frozen_string_literal: true

class ComparisonResult < ApplicationRecord
  belongs_to :report, class_name: 'ComparisonReport', foreign_key: 'comparison_report_id', inverse_of: :results
end
