require 'spec_helper'

describe "group_categories/show" do
  before(:each) do
    @group_category = assign(:group_category, stub_model(GroupCategory))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
