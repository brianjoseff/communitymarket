require 'spec_helper'

describe "email_settings/new" do
  before(:each) do
    assign(:email_setting, stub_model(EmailSetting,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new email_setting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => email_settings_path, :method => "post" do
      assert_select "input#email_setting_name", :name => "email_setting[name]"
    end
  end
end
