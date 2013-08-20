desc "This task is called by the Heroku scheduler add-on"
task :send_daily_aggregate_emails => :environment do
  
  DailyQueue.send_email
  
end

task :send_weekly_aggregate_emails => :environment do
  WeeklyQueue.send_email
end