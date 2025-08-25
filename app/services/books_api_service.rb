require 'net/http'
require 'json'

class BooksApiService
  BASE_URL = "https://www.googleapis.com/books/v1/volumes"

  def self.fetch_books(limit = 100)
    books = []
    start_index = 0

    while books.size < limit
      url = "#{BASE_URL}?q=a&maxResults=40&startIndex=#{start_index}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      result = JSON.parse(response)

      items = result["items"] || []
      books.concat(items)

      start_index += 40
      break if items.empty?
    end

    books.first(limit)
  rescue => e
    puts "❌ Error fetching books: #{e.message}"
    []
  end
end
