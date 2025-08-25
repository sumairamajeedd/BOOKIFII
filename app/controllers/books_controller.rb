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

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    #@book = Book.new(book_params)
    #if @book.save
      #redirect_to @book, notice: "Book was successfully created."
    #else
      #render :new, status: :unprocessable_entity
    #end
  end

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    #if @book.update(book_params)
      #redirect_to @book, notice: "Book was successfully updated."
    #else
     # render :edit, status: :unprocessable_entity
    #end
  end

  # DELETE /books/:id
  def destroy
    #@book.destroy
    #redirect_to books_path, notice: "Book was successfully deleted."
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
