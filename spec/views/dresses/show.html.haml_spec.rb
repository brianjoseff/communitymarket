require 'spec_helper'

describe "dresses/show" do
  before(:each) do
    @dress = assign(:dress, stub_model(Dress,
      :size => "Size",
      :rental => 1,
      :title => "Title",
      :retail => 2,
      :comments_on_fit => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Size/)
    rendered.should match(/1/)
    rendered.should match(/Title/)
    rendered.should match(/2/)
    rendered.should match(/MyText/)
  end
end
