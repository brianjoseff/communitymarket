require 'spec_helper'

describe "email_settings/edit" do
  before(:each) do
    @email_setting = assign(:email_setting, stub_model(EmailSetting,
      :name => "MyString"
    ))
  end

  it "renders the edit email_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => email_settings_path(@email_setting), :method => "post" do
      assert_select "input#email_setting_name", :name => "email_setting[name]"
    end
  end
end
