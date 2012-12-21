require 'spec_helper'

describe "Tabs", :js => true do
  before(:each) do
    DatabaseCleaner.clean
  end
  
  let(:tab) { create(:tab) }
  describe 'flash' do
    before {
      visit '/tabs/new'
      fill_in 'tab[title]', :with => tab.title
      fill_in 'tab[content]',:with =>  tab.content
      click_button 'Create Tab'
    }
    
    it 'can toggle flash off' do
      visit '/tabs/new'
      fill_in 'tab[title]', :with => tab.title
      fill_in 'tab[content]',:with =>  tab.content
      click_button 'Create Tab'
      page.should have_css '.flash-message.error'
      click_link 'close'
      sleep 3
      find('.flash-message.error').visible?.should eq(false)
    end
  end
end