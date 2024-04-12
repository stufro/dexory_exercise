FactoryBot.define do
  factory :scan_result do
    sequence(:name) { |n| "ZA00#{n}A" }
    scanned { [true, false].sample }
    occupied { [true, false].sample }
    sequence(:detected_barcodes) { |n| ["ABC#{n}"] }
  end
end
