namespace :books do
  desc "Fetch books from Google Books API and populate the database"
  task fetch: :environment do
    require 'net/http'
    require 'json'

    puts "Fetching books from Google Books API..."

    query = ENV['BOOK_QUERY'] || "programming"  # default query
    max_results = 40
    api_key = ENV['GOOGLE_BOOKS_API_KEY']       # store your API key in ENV

    url = "https://www.googleapis.com/books/v1/volumes?q=#{query}&maxResults=#{max_results}&key=#{api_key}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    data['items']&.each do |item|
      info = item['volumeInfo']
      
      # Avoid duplicates
      next if Book.exists?(google_book_id: item['id'])

      Book.create!(
        google_book_id: item['id'],
        title: info['title'],
        author: (info['authors'] || []).join(", "),
        publisher: info['publisher'],
        published_date: info['publishedDate'],
        description: info['description'],
        category: info['categories']&.first,
        language: info['language'],
        average_rating: info['averageRating'],
        ratings_count: info['ratingsCount'],
        thumbnail: info.dig('imageLinks', 'thumbnail'),
        small_thumbnail: info.dig('imageLinks', 'smallThumbnail')
      )
    end

    puts "Books imported successfully!"
  end
end
