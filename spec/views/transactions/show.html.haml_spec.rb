require 'spec_helper'

describe "transactions/show" do
  before(:each) do
    @transaction = assign(:transaction, stub_model(Transaction,
      :price => 1,
      :tier_id => 2,
      :premium => false,
      :notify_premium => 3,
      :user_id => 4,
      :customer_id => 5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/false/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
  end
end
