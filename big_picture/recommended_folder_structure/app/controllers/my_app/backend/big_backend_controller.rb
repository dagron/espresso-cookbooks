module MyApp::Backend
  class BigBackendController < E
    map '/big'
    def index
      "big backend controller"
    end
  end
end