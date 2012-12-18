ActiveRecord::Base.establish_connection(:adapter => "slite3", :db => "db/example.sqlite3")
class User < ActiveRecord::Base
  col :username
  col :email
  timestamps
end
User.auto_upgrade!
unless User.first
  100.times do |i|
    User.create(:username => "User_#{i}", :email => "email-#{i}@example.com")
  end
end