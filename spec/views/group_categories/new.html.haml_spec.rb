require 'spec_helper'

describe "group_categories/new" do
  before(:each) do
    assign(:group_category, stub_model(GroupCategory).as_new_record)
  end

  it "renders new group_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_categories_path, :method => "post" do
    end
  end
end
