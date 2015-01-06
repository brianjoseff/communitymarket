require 'rails_helper'

RSpec.describe "schools/index", :type => :view do
  before(:each) do
    assign(:schools, [
      School.create!(
        :name => "Name",
        :location => "Location"
      ),
      School.create!(
        :name => "Name",
        :location => "Location"
      )
    ])
  end

  it "renders a list of schools" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
  end
end
