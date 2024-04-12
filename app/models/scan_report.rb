# frozen_string_literal: true

class ScanReport < ApplicationRecord
  has_many :results, class_name: 'ScanResult', dependent: :destroy
end
