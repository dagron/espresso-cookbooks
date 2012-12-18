module MyApp::Frontend
  class Pagination < E
    map '/pagination'
    def index
      @users = User.paginate(:page => params[:page], :per_page => 3)
    end
  end
end