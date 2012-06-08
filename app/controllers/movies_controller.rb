class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
  
	@checked_ratings = params[:ratings]
    @all_ratings = Movie.getAllRatings
    if params[:title_header] == ""
      params[:title_header] = 0
    end
    if params[:release_date_header] = ""
      params[:release_date_header] = 0
    end
    if params.has_key?(:title_header) and Integer(params[:title_header]) == 1
      @highlight_title = true
      @movies = Movie.order(:title)
    elsif params.has_key?(:release_date_header) and Integer(params[:release_date_header]) == 1
      @highlight_release_date = true
      @movies = Movie.order(:release_date)
    else
      @movies = []
      if @checked_ratings
        @checked_ratings.each do |rating|
          Movie.getMoviesWithRating(rating).each do |movie|
            @movies << movie
          end
        end
        return @movies
      else
        @movies = []
      end
      return @movies        
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end
  
  def show_order_by_title
    
  end

end
