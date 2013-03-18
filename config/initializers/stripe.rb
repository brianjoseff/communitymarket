if Rails.env.production?
  Stripe.api_key = "sk_live_9AOaAWh9NM7FXJEAMsAO2PQI"
  STRIPE_PUBLIC_KEY = "pk_live_A2QhMLGwBYwtdApBDzrGouGT"
else
  Stripe.api_key = "sk_test_I3kmdJD9gmYwkbPxnQewfgiH"
  STRIPE_PUBLIC_KEY = "pk_test_RygB7MTey2Py6OYk0b8vC2uO" 
end
