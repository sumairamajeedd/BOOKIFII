class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    # Ransack search
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
  end

  # GET /books/:id
  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  
  def create
    
  end

 
  def edit
  end

  
  def update
    
  end

 
  def destroy
  end

  private

  def set_book
   
  end

  def book_params
    params.require(:book).permit(
      :google_book_id,
      :title,
      :author,
      :publisher,
      :published_date,
      :description,
      :category,
      :language,
      :average_rating,
      :ratings_count,
      :country,
      :saleability,
      :is_ebook,
      :thumbnail,
      :small_thumbnail
    )
  end
end
