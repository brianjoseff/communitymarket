

namespace :db do
  desc "add Tiers 1-6"
  task :add_tiers => :environment do
    require 'faker'
    require 'forgery'
    Tier.delete_all
    Tier.reset_pk_sequence
    #tiers
    Tier.create!(:name => "$1-5: Tier 1", :price => 250, :id => 1)
    Tier.create!(:name => "$6-10: Tier 2", :price => 600, :id => 2)
    Tier.create!(:name => "$11-25: Tier 3", :price => 1200, :id => 3)
    Tier.create!(:name => "$26-50: Tier 4", :price => 3000, :id => 4)
    Tier.create!(:name => "$51-99: Tier 5", :price => 6000, :id => 5)
    Tier.create!(:name => "$100+: Tier 6", :price => 1100, :id => 6)

  end
end
