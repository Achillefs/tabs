require 'spec_helper'

describe TabsController do
  describe '#new' do
    before { get :new }
    
    it { response.code.to_i.should eq(200) }
  end
end
