class ScanReport < ApplicationRecord
  has_many :results, class_name: 'ScanResult'
end
