# frozen_string_literal: true

class ScanReport < ApplicationRecord
  has_many :results, class_name: 'ScanResult', dependent: :destroy
  has_many :comparison_reports, dependent: :destroy
end
