require 'spec_helper'

describe "posts/index" do
  before(:each) do
    assign(:posts, [
      stub_model(Post,
        :title => "Title",
        :borrow => false,
        :tier => 1,
        :description => "MyText",
        :user_id => 2,
        :post_category_id => 3,
        :premium => false
      ),
      stub_model(Post,
        :title => "Title",
        :borrow => false,
        :tier => 1,
        :description => "MyText",
        :user_id => 2,
        :post_category_id => 3,
        :premium => false
      )
    ])
  end

  it "renders a list of posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
