require 'spec_helper'

describe "posts/edit" do
  before(:each) do
    @post = assign(:post, stub_model(Post,
      :title => "MyString",
      :borrow => false,
      :tier => 1,
      :description => "MyText",
      :user_id => 1,
      :post_category_id => 1,
      :premium => false
    ))
  end

  it "renders the edit post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => posts_path(@post), :method => "post" do
      assert_select "input#post_title", :name => "post[title]"
      assert_select "input#post_borrow", :name => "post[borrow]"
      assert_select "input#post_tier", :name => "post[tier]"
      assert_select "textarea#post_description", :name => "post[description]"
      assert_select "input#post_user_id", :name => "post[user_id]"
      assert_select "input#post_post_category_id", :name => "post[post_category_id]"
      assert_select "input#post_premium", :name => "post[premium]"
    end
  end
end
