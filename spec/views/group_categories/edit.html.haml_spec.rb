require 'spec_helper'

describe "group_categories/edit" do
  before(:each) do
    @group_category = assign(:group_category, stub_model(GroupCategory))
  end

  it "renders the edit group_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => group_categories_path(@group_category), :method => "post" do
    end
  end
end
