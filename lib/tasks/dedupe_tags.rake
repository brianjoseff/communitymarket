task :dedupe_tags => :environment do
  puts "Removing duplicates in table tags"
  puts "Entries before: #{n1=Tag.count}"
  sql = "delete e1 from tags e1, tags e2 "+
        "where (e1.name = e2.name) "+
        "and (e1.id > e2.id);"
  ActiveRecord::Base.connection.execute(sql);
  puts "Entries after: #{n2=Tag.count}, #{n1-n2} duplicates removed"
end