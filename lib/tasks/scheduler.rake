desc "This task is called by the Heroku scheduler add-on"
task :send_group_daily_aggregate_emails => :environment do
  puts "sending daily emails to users..."
  DailyQueue.send_email 
  puts "done sending emails."
end

task :send_weekly_aggregate_emails => :environment do
  puts "sending weekly emails to users..."
  WeeklyQueue.send_email
  puts "done sending emails."
end