class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    @sort = params[:sort] ? params[:sort] : session[:sort]
    @ratings = params[:ratings] ? params[:ratings] : session[:ratings] # ratings=>{"G"=>"1", "R"=>"1"} those checked

    @movies = Movie.all
    @all_ratings = Movie.all_ratings

    #Hash use the key function
    #s.t. ratings.key (https://ruby-doc.org/core-2.2.3/Hash.html)

    # 4 Parameters (http://guides.rubyonrails.org/action_controller_overview.html)
    if @sort.nil?
      if @sort == "title"
        session[:sort] = "title"
      elsif @sort == "release_date"
        session[:sort] = "release_date"
      end
    end

    if session[:sort].nil?
      @movies = Movie.order(session[:sort])
      if session[:sort] == "title"
        @t_highlight = "hilite"
      elsif session[:sort] == "release_date"
        @m_highlight = "hilite"
      end
    end

    if !@ratings.nil?
      @movies.where!({rating: @ratings.keys})
    else
      @ratings = Movie.all_ratings
    end

    # this should work when there is a sort and rating
    if !@sort.nil? and !@ratings.nil?
      # @movies = Movie.where!({rating: @ratings}).order(@sort)
      # @movies.where!({rating: @ratings.keys})
    end

    session[:sort] = @sort
    session[:ratings] = @ratings
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
