require 'spec_helper'

describe "Tabs", js: true do
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
      page.should have_css '.field_with_errors', count: 1
      click_link 'close'
      sleep 2
      page.should_not have_css '.flash-message.error'
    end
  end
  
  describe 'new' do
    before { visit '/tabs/new' }
    
    it 'displays a blank tab' do
      page.should have_css '.fretboard.row', count: 1
      page.should have_css '.column.grid1', count: 30
    end
    
    it 'listens to keyboard navigation' do
      page.should have_css '.s1.current', count: 1
      
      send_keys :arrow_up
      page.should_not have_css '.v1 .s1.current'
      page.should have_css '.v1 .s2.current', count: 1
      
      send_keys :arrow_left
      page.should_not have_css '.v1 .s2.current'
      page.should have_css '.v30 .s2.current', count: 1
      
      send_keys :arrow_right
      page.should_not have_css '.v30 .s2.current'
      page.should have_css '.v1 .s2.current', count: 1
      
      send_keys :arrow_right
      page.should_not have_css '.v1 .s2.current'
      page.should have_css '.v2 .s2.current', count: 1
      
      send_keys :arrow_down
      page.should_not have_css '.v2 .s2.current'
      page.should have_css '.v2 .s1.current', count: 1
      
      send_keys :arrow_down
      page.should_not have_css '.v2 .s1.current'
      page.should have_css '.v2 .s6.current', count: 1
    end
    
    it 'allows fret number input' do
      send_keys '5'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '5'
      send_keys '1'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '1'
      send_keys '2'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '12'
      send_keys :backspace
      page.should have_css 'div#g1_1', text: ''
      send_keys '24'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '24'
      send_keys '8'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '8'
    end
    
    it 'listens to qweasdx keys for non-numpad keyboards' do
      send_keys 's'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '8'
      send_keys 'x'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '0'
      send_keys '1q'
      sleep 0.3
      page.should have_css 'div#g1_1', text: '14'
    end
    
    it 'attempts to save on ctrl+s' do
      send_keys [:control, 's']
      page.should have_css '#errorExplanation'
    end
    
    it 'can save a tab' do
      fill_in 'tab_title', with: 'test'
      send_keys '5'
      send_keys :arrow_right
      send_keys :arrow_right
      send_keys '12'
      send_keys :arrow_up
      send_keys '11'
      click_button 'Create Tab'
      page.should_not have_css '#errorExplanation'
      current_path.should eq("/tabs/#{Tab.last.id}")
      click_link 'edit'
      page.should have_css 'div#g1_1', text: '5'
      page.should have_css 'div#g3_1', text: '12'
      page.should have_css 'div#g3_2', text: '11'
    end
  end
end