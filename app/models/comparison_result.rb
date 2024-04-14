# frozen_string_literal: true

class ComparisonResult < ApplicationRecord
  belongs_to :report, class_name: 'ComparisonReport', foreign_key: 'comparison_report_id', inverse_of: :results

  def status
    if expected_barcodes.present?
      return :empty_unexpected if detected_barcodes.blank?

      expected_barcodes == detected_barcodes ? :occupied_expected : :occupied_incorrect
    else
      detected_barcodes.present? ? :occupied_unexpected : :empty_expected
    end
  end
end
