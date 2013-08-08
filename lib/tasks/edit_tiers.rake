

namespace :db do
  desc "change names of tiers"
  task :edit_tiers => :environment do
    require 'faker'
    require 'forgery'
    Tier.delete_all
    Tier.reset_pk_sequence
    #tiers
    Tier.create!(:name => "$1-5: Trinket", :id => 1)
    Tier.create!(:name => "$6-10: Bauble", :id => 2)
    Tier.create!(:name => "$11-25: Thing", :id => 3)
    Tier.create!(:name => "$26-50: Big Stuff", :id => 4)
    Tier.create!(:name => "$51-99: Muy Grande", :id => 5)
    Tier.create!(:name => "$100+: Super Grande Deluxe", :id => 6)
    
  end
end 
