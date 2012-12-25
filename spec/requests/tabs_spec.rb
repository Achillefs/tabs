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
      
      send_keys :arrow_up
      page.should_not have_css '.v1 .s1.current'
      page.should have_css '.v1 .s2.current', :count => 1
      
      send_keys :arrow_left
      page.should_not have_css '.v1 .s2.current'
      page.should have_css '.v30 .s2.current', :count => 1
      
      send_keys :arrow_right
      page.should_not have_css '.v30 .s2.current'
      page.should have_css '.v1 .s2.current', :count => 1
      
      send_keys :arrow_right
      page.should_not have_css '.v1 .s2.current'
      page.should have_css '.v2 .s2.current', :count => 1
      
      send_keys :arrow_down
      page.should_not have_css '.v2 .s2.current'
      page.should have_css '.v2 .s1.current', :count => 1
      
      send_keys :arrow_down
      page.should_not have_css '.v2 .s1.current'
      page.should have_css '.v2 .s6.current', :count => 1
    end
    
    it 'allows fret number input' do
      send_keys '5'
      sleep 1
      page.should have_css 'div#1_1', :text => '5'
      send_keys '1'
      sleep 1
      page.should have_css 'div#1_1', :text => '1'
      send_keys '2'
      sleep 1
      page.should have_css 'div#1_1', :text => '12'
      send_keys :backspace
      page.should have_css 'div#1_1', :text => ''
      send_keys '24'
      sleep 1
      page.should have_css 'div#1_1', :text => '24'
      send_keys '8'
      sleep 1
      page.should have_css 'div#1_1', :text => '8'
    end
  end
end