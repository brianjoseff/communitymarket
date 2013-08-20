require 'spec_helper'

describe "email_settings/show" do
  before(:each) do
    @email_setting = assign(:email_setting, stub_model(EmailSetting,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
