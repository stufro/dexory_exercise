require 'rails_helper'

RSpec.describe 'Comparison Reports' do
  describe 'index page' do
    it 'shows a list of comparison reports' do
      report = ComparisonReport.create(created_by: 'Alice Bob')
      visit '/'
      expect(page).to have_content('Alice Bob')
    end
  end
end
