require 'spec_helper'

describe "dresses/index" do
  before(:each) do
    assign(:dresses, [
      stub_model(Dress,
        :size => "Size",
        :rental => 1,
        :title => "Title",
        :retail => 2,
        :comments_on_fit => "MyText"
      ),
      stub_model(Dress,
        :size => "Size",
        :rental => 1,
        :title => "Title",
        :retail => 2,
        :comments_on_fit => "MyText"
      )
    ])
  end

  it "renders a list of dresses" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Size".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
