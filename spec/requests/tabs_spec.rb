require 'spec_helper'

describe "Tabs", :js => true do
  before(:each) do
    DatabaseCleaner.clean
  end
  
  let(:tab) { create(:tab) }
  describe 'flash' do
    it 'can toggle flash off' do
      visit '/tabs/new'
      click_button 'Create Tab'
      page.should have_css '.flash-message.error'
      page.should have_css '#errorExplanation'
      page.should have_css '.field_with_errors', 2
      click_link 'close'
      sleep 3
      find('.flash-message.error').visible?.should eq(false)
    end
  end
end