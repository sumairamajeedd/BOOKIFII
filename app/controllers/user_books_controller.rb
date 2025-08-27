class UserBooksController < ApplicationController
  before_action :authenticate_user!

  def create
    book = Book.find(params[:book_id])
    current_user.user_books.create(book: book, status: params[:status] || "completed")
    redirect_to book, notice: "Book added to your list!"
  end
end
