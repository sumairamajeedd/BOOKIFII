class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:query].present?
      query = params[:query].downcase
      @books = Book.where("LOWER(title) LIKE ? OR LOWER(author) LIKE ?", "%#{query}%", "%#{query}%")
    else
      @books = Book.all.limit(40)
    end
  end
end
