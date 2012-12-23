require 'spec_helper'

describe TabsController do
  describe '#new' do
    before { get :new }
    
    it { response.code.to_i.should eq(200) }
    it { response.should render_template("new") }
    it { assigns(:tab).should be_a_new(Tab) }
  end
  
  describe '#create' do
    before { 
      tab = build(:tab)
      post :create, :tab => { :title => tab.title, :content => tab.content }
    }
    
    it { response.code.to_i.should eq(302) }
    it { assigns(:tab).should eq(Tab.first) }
    it "should not allow dupes" do
      post :create, build(:tab).attributes
      response.code.to_i.should eq(200)
      flash[:error].should_not eq(nil)
    end
  end
  describe "#show" do
    before { @tab = create(:tab); get :show, :id => @tab.id }
    
    it { response.code.to_i.should eq(200) }
    it { response.should render_template("show") }
    it { assigns(:tab).should eq(@tab) }
  end
  
  describe "#edit" do
    before { @tab = create(:tab); get :edit, :id => @tab.id }
    
    it { response.code.to_i.should eq(200) }
    it { response.should render_template("new") }
    it { assigns(:tab).should eq(@tab) }
  end
end
