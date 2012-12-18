require './app'

app = EApp.new do
  mount MyApp::Frontend, '/'
  mount MyApp::Backend,  '/backend' do
    digest_auth do |user|
      users = { 'admin' => 'password' }
      users[user]
    end
  end
  assets_map :assets, :assets_server
end
app.session :cookies
run app