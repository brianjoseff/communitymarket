namespace :db do
  desc "add thirty users"
  task :add_users => :environment do
    require 'faker'
    require 'forgery'

    #users
    30.times do |n|
      name = Faker::Name.name
      email = Faker::Name.first_name + '@' + Forgery(:LoremIpsum).word(:random => true) + '.edu'
      password = Forgery(:basic).password

      # zip = Forgery(:address).zip
      User.create!(:name => name,
                   :email => email,
                   :password => "password")
    end

  end
end