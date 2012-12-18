ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "db/example.sqlite3")
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