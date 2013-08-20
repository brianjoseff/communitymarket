namespace :filter do
  desc "filter daily members out"
  task :members => :environment do
    post = Post.find(52)
    groups = post.groups
    all_memberships = []
    for group in groups do
      Membership.where(:group_id => group.id).each do |membership|
        all_memberships << membership
      end
    end

    all_memberships = all_memberships.uniq
    wtf = []
    wtf = all_memberships.select{|membership| membership.email_setting_id == 0}
    every_post = []
    every_post = all_memberships.select{|membership| membership.email_setting_id == 1}
    no_email_settings = []
    no_email_settings = all_memberships.select{|membership| membership.email_setting_id == nil}
    daily_memberships = []
    daily_memberships = all_memberships.select{|membership| membership.email_setting_id == 2}
    weekly_membership = []
    weekly_membership = all_memberships.select{|membership| membership.email_setting_id == 3}
    daily_agg = []
    daily_agg = all_memberships.select{|membership| membership.email_setting_id == 4}
    weekly_agg = []
    weekly_agg = all_memberships.select{|membership| membership.email_setting_id == 5}
    off = []
    off = all_memberships.select{|membership| membership.email_setting_id == 6}

    puts all_memberships.size
    puts "wtf size" 
    puts wtf.size
    puts "every post size"
    puts every_post.size
    puts "No email Size"
    puts no_email_settings.size
    puts "daily size"
    puts daily_memberships.size
    puts "weekly size"
    puts weekly_membership.size
    puts "daily agg size"
    puts daily_agg.size
    puts "weekly agg size"
    puts weekly_agg.size
    puts "off size"
    puts off.size
  end
end 
    
