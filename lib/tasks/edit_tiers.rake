

namespace :db do
  desc "change names of tiers"
  task :edit_tiers => :environment do
    require 'faker'
    require 'forgery'
    Tier.delete_all
    Tier.reset_pk_sequence
    #tiers
    Tier.create!(:name => "$1-5: Tier 1", :id => 1)
    Tier.create!(:name => "$6-10: Tier 2", :id => 2)
    Tier.create!(:name => "$11-25: Tier 3", :id => 3)
    Tier.create!(:name => "$26-50: Tier 4", :id => 4)
    Tier.create!(:name => "$51-99: Tier 5", :id => 5)
    Tier.create!(:name => "$100+: Tier 6", :id => 6)
    
  end
end 
