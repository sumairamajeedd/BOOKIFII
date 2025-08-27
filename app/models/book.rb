class Book < ApplicationRecord
  # agar meri  associations hain to unke liye bhi ransackable_associations define karna hoga
  
  has_many :user_books
  has_many :users, through: :user_books


  def self.ransackable_attributes(auth_object = nil)
    [
      "title", "author", "publisher", "published_date",
      "description", "category", "language", "average_rating",
      "ratings_count", "country", "saleability", "is_ebook",
      "thumbnail", "small_thumbnail", "google_book_id", "created_at", "updated_at"
    ]
  end

  # Returns an array of association names that are allowed to be searched or filtered using Ransack.
  # By default, this method returns an empty array, meaning no associations are ransackable.
  # To enable searching/filtering on associations (e.g., has_many, belongs_to), add their names to the returned array.
  #
  # @param auth_object [Object, nil] Optional authorization object (not used by default).
  # @return [Array<String>] List of ransackable association names.
  def self.ransackable_associations(auth_object = nil)
    []  # agar koi associations hain (jaise has_many, belongs_to), to unka naam idhar daalna
  end
end
