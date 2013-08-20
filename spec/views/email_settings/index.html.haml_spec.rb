require 'spec_helper'

describe "email_settings/index" do
  before(:each) do
    assign(:email_settings, [
      stub_model(EmailSetting,
        :name => "Name"
      ),
      stub_model(EmailSetting,
        :name => "Name"
      )
    ])
  end

  it "renders a list of email_settings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
