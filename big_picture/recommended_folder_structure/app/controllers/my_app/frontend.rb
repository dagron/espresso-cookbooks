module MyApp::Frontend
  class Home < E
    map '/'
    def index
      "frontend home"
    end
  end
end