# app/services/recommendation_service.rb
class RecommendationService
  STOPWORDS = %w[a an the and or but if then else when while for on in at to from of with by is are was were].freeze
  TITLE_WEIGHT = 3
  DESC_WEIGHT  = 1

  def initialize(user, read_books: nil)
    @user = user
    # Sirf "read" status wali books consider karo
    @read_books = read_books || @user.user_books.where(status: "read").includes(:book).map(&:book)
  end

  # 🔹 Word-based recommendation (content similarity)
  def by_words(limit = 5)
    return fallback_books(limit) if @read_books.empty?

    profile = build_profile(@read_books)

    Book.where.not(id: @read_books.map(&:id))
        .map { |b| { book: b, score: score_book(b, profile) } }
        .sort_by { |h| -h[:score] }
        .reject { |h| h[:score].zero? }
        .first(limit)
        .map { |h| h[:book] }
  end

  # 🔹 Category-based recommendation (fav category)
  def by_category(limit = 5)
    return fallback_books(limit) if @read_books.empty?

    fav = top_category(@read_books)
    return fallback_books(limit) unless fav

    Book.where(category: fav)
        .where.not(id: @read_books.map(&:id))
        .limit(limit)
  end

  private

  # Extract words from title/description
  def extract_words(text)
    text.to_s.downcase
        .gsub(/[^a-z\s]/, ' ')
        .split
        .reject { |w| w.length < 3 || STOPWORDS.include?(w) }
  end

  # Build user profile from read books
  def build_profile(books)
    counts = Hash.new(0)
    books.each do |book|
      extract_words(book.title).each { |w| counts[w] += TITLE_WEIGHT }
      extract_words(book.description).each { |w| counts[w] += DESC_WEIGHT }
    end
    counts
  end

  # Score book based on profile
  def score_book(book, profile)
    score = 0
    extract_words(book.title).each { |w| score += (profile[w] || 0) * TITLE_WEIGHT }
    extract_words(book.description).each { |w| score += (profile[w] || 0) * DESC_WEIGHT }
    score
  end

  # Find top category among read books
  def top_category(books)
    cats = books.pluck(:category).compact
    return nil if cats.empty?

    cats.tally.max_by { |_, c| c }&.first
  end

  # 🔹 fallback books agar read_books empty ho
  def fallback_books(limit = 5)
    Book.order("RANDOM()").limit(limit)
  end
end
