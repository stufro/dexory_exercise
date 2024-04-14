# frozen_string_literal: true

class ComparisonResult < ApplicationRecord
  belongs_to :report, class_name: 'ComparisonReport', foreign_key: 'comparison_report_id', inverse_of: :results

  def status
    return :empty_unexpected if expected_barcodes.present? && detected_barcodes.blank?
    return :occupied_expected if expected_barcodes.present? && expected_barcodes == detected_barcodes
    return :occupied_unexpected if expected_barcodes.blank? && detected_barcodes.present?
    return :occupied_incorrect if expected_barcodes.present? && expected_barcodes != detected_barcodes

    :empty_expected if expected_barcodes.blank? && detected_barcodes.blank?
  end
end
