class Book < ApplicationRecord
  # agar tumhare associations hain to unke liye bhi ransackable_associations define karna hoga

  def self.ransackable_attributes(auth_object = nil)
    [
      "title", "author", "publisher", "published_date",
      "description", "category", "language", "average_rating",
      "ratings_count", "country", "saleability", "is_ebook",
      "thumbnail", "small_thumbnail", "google_book_id", "created_at", "updated_at"
    ]
  end

  def self.ransackable_associations(auth_object = nil)
    []  # agar koi associations hain (jaise has_many, belongs_to), to unka naam idhar daalna
  end
end
