class RecommendedBooksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "recommended_books_channel"
  end

  def unsubscribed
   
  end
end
