require 'spec_helper'

describe "transactions/new" do
  before(:each) do
    assign(:transaction, stub_model(Transaction,
      :price => 1,
      :tier_id => 1,
      :premium => false,
      :notify_premium => 1,
      :user_id => 1,
      :customer_id => 1
    ).as_new_record)
  end

  it "renders new transaction form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => transactions_path, :method => "post" do
      assert_select "input#transaction_price", :name => "transaction[price]"
      assert_select "input#transaction_tier_id", :name => "transaction[tier_id]"
      assert_select "input#transaction_premium", :name => "transaction[premium]"
      assert_select "input#transaction_notify_premium", :name => "transaction[notify_premium]"
      assert_select "input#transaction_user_id", :name => "transaction[user_id]"
      assert_select "input#transaction_customer_id", :name => "transaction[customer_id]"
    end
  end
end
