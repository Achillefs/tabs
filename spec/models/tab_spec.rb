require 'spec_helper'

describe Tab do
  subject { create(:tab) }
  
  it { subject.instrument.should eq('guitar') }
  it { subject.has_user?.should eq(true) }
  it { subject.tab_length.should eq(7) }
  it "doesn't allow 2 tabs with the same name" do
    first_tab = subject
    expect { create(:tab) }.to raise_error(ActiveRecord::RecordInvalid)
  end
  it { subject.to_text.should eq("---------------------
---------------------
---------------------
---------------------
2--5--7--------------
0--3--5--0--3--6--5--") }
end