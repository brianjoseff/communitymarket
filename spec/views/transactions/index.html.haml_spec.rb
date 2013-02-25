require 'spec_helper'

describe "transactions/index" do
  before(:each) do
    assign(:transactions, [
      stub_model(Transaction,
        :price => 1,
        :tier_id => 2,
        :premium => false,
        :notify_premium => 3,
        :user_id => 4,
        :customer_id => 5
      ),
      stub_model(Transaction,
        :price => 1,
        :tier_id => 2,
        :premium => false,
        :notify_premium => 3,
        :user_id => 4,
        :customer_id => 5
      )
    ])
  end

  it "renders a list of transactions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
