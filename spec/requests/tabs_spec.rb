require 'spec_helper'

describe "Tabs", :js => true do
  include IntegrationHelpers
  
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
      page.should have_css '.field_with_errors', :count => 1
      click_link 'close'
      sleep 3
      find('.flash-message.error').visible?.should eq(false)
    end
  end
  
  describe 'new' do
    before {
      visit '/tabs/new'
    }
    
    it 'displays a blank tab' do
      page.should have_css '.fretboard.row', :count => 1
      page.should have_css '.column.grid1', :count => 30
    end
    
    it 'listens to keyboard navigation' do
      page.should have_css '.s1.current', :count => 1
      sleep 1
      send_keys 38
      page.should_not have_css '.s1.current'
      page.should have_css '.s2.current', :count => 1
    end
  end
end