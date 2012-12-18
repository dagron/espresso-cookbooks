module MyApp::Backend
  class Home < E
    map '/'
    def index
      "backend home"
    end
  end
end