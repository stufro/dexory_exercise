require 'net/http'

task :api_seed do
  json_data = Rails.root.join('spec/fixtures/example-customer.json').read
  response = Net::HTTP.post URI('http://localhost:3000/scan_reports'),
                            json_data,
                            'Content-Type' => 'application/json'
  puts response.body
end
