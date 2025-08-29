class BooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  def index
    # Ransack search
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)

    # Recommended Books for logged-in users
    if user_signed_in? 
      service = RecommendationService.new(current_user)
      @word_recommended     = service.by_words(7)      # word-based recommendations
       @category_recommended = service.by_category(7)   # category-based recommendations
    else
      @word_recommended     = []
      @category_recommended = []
    end
# Flag to check if search was performed
  @search_performed = params[:q].present? && params[:q].values.any?(&:present?)
end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /books/:id/edit
  def edit
  end
# PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "Book was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book was successfully deleted."
  end

  # GET /books/recommended (optional separate page)
  def recommended
    service = RecommendationService.new(current_user)
    limit = params[:limit].presence&.to_i || 7
    @word_recommended     = service.by_words(limit)
    @category_recommended = service.by_category(limit)
  end

  private

  def set_book
    @book = Book.find(params[:id])
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
