ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "db/example.sqlite3")
class User < ActiveRecord::Base
  col :login
  col :password
  col :email
  timestamps

  def self.authenticate(login, password)
    where(:login => login, :password => password).first
  end

end
User.auto_upgrade!
unless User.first
  100.times do |i|
    User.create(:login => "user_#{i}", :email => "email-#{i}@example.com", :password => 'test')
  end
end