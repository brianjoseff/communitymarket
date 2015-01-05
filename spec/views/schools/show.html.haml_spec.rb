require 'rails_helper'

RSpec.describe "schools/show", :type => :view do
  before(:each) do
    @school = assign(:school, School.create!(
      :name => "Name",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Location/)
  end
end
