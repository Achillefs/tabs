require 'spec_helper'

describe TabsController do
  describe '#new' do
    before { get :new }
    
    it { response.code.to_i.should eq(200) }
    it { assigns(:tab).should be_a_new(Tab) }
  end
  
  describe '#create' do
    before { post :create, build(:tab).attributes }
    
    it { response.code.to_i.should eq(302) }
    it { assigns(:tab).should eq(Tab.first) }
    
    it "should not allow dupes" do
      post :create, build(:tab).attributes
      response.code.to_i.should eq(200)
      flash[:error].should_not eq(nil)
    end
    
  end
end
