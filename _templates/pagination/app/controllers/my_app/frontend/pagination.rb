module MyApp::Frontend
  class Pagination < E
    include WillPaginate::E::Helpers
    map '/pagination'
    def index
      @users = User.paginate(:page => params[:page], :per_page => 3)
      render_p :index
    end
  end
end