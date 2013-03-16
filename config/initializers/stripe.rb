if Rails.env.production?
  Stripe.api_key = "NAExLd4KaYKZOgGwghofgp4h6oQb1yhT"
  STRIPE_PUBLIC_KEY = "pk_bbFEct0YyZO6Yx1a2zGyxmGbSyfRr"
else
  Stripe.api_key = "sk_test_I3kmdJD9gmYwkbPxnQewfgiH"
  STRIPE_PUBLIC_KEY = "pk_test_RygB7MTey2Py6OYk0b8vC2uO" 
end
