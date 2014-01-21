if Rails.env.production?
  Stripe.api_key = ENV["STRIPE_SECRET"]
  STRIPE_PUBLIC_KEY = "pk_live_A2QhMLGwBYwtdApBDzrGouGT"
else
  Stripe.api_key = ENV["STRIPE_TEST_SECRET"]
  STRIPE_PUBLIC_KEY = "pk_test_RygB7MTey2Py6OYk0b8vC2uO" 
end
