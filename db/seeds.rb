require 'open-uri'
require 'json'
require 'erb'  # Add this for ERB::Util

def fetch_books(query, start_index=0, max_results=40)
  api_key = Rails.application.credentials.google_books_api_key
  query_encoded = ERB::Util.url_encode(query)  # Fixed line
  url = "https://www.googleapis.com/books/v1/volumes?q=#{query_encoded}&key=#{api_key}&maxResults=#{max_results}&startIndex=#{start_index}"
  response = URI.open(url).read
  JSON.parse(response)['items'] || []
end

query = "programming"  # Change topic as needed
total_books = 100
books_fetched = 0
start_index = 0

while books_fetched < total_books
  remaining = total_books - books_fetched
  max_results = remaining > 40 ? 40 : remaining
  books = fetch_books(query, start_index, max_results)
  break if books.empty?

  books.each do |book|
    info = book['volumeInfo']
    sale = book['saleInfo']

    Book.create!(
      google_book_id: book['id'],
      title: info['title'],
      author: (info['authors'] || []).join(", "),
      publisher: info['publisher'],
      published_date: info['publishedDate'],
      description: info['description'],
      category: info['categories']&.first,
      language: info['language'],
      average_rating: info['averageRating'],
      ratings_count: info['ratingsCount'],
      country: sale['country'],
      saleability: sale['saleability'],
      is_ebook: sale['isEbook'],
      thumbnail: info.dig('imageLinks', 'thumbnail'),
      small_thumbnail: info.dig('imageLinks', 'smallThumbnail')
    )
  end

  books_fetched += books.size
  start_index += books.size
end
