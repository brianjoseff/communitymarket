require 'spec_helper'

describe "dresses/edit" do
  before(:each) do
    @dress = assign(:dress, stub_model(Dress,
      :size => "MyString",
      :rental => 1,
      :title => "MyString",
      :retail => 1,
      :comments_on_fit => "MyText"
    ))
  end

  it "renders the edit dress form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", dress_path(@dress), "post" do
      assert_select "input#dress_size[name=?]", "dress[size]"
      assert_select "input#dress_rental[name=?]", "dress[rental]"
      assert_select "input#dress_title[name=?]", "dress[title]"
      assert_select "input#dress_retail[name=?]", "dress[retail]"
      assert_select "textarea#dress_comments_on_fit[name=?]", "dress[comments_on_fit]"
    end
  end
end
