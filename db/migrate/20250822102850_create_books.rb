class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :google_book_id
      t.string :title
      t.string :author
      t.string :publisher
      t.date :published_date
      t.text :description
      t.string :category
      t.string :language
      t.float :average_rating
      t.integer :ratings_count
      t.string :country
      t.string :saleability
      t.boolean :is_ebook

      t.timestamps
    end
  end
end
