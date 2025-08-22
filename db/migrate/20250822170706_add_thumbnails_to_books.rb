class AddThumbnailsToBooks < ActiveRecord::Migration[8.0]
  def change
    add_column :books, :thumbnail, :string
    add_column :books, :small_thumbnail, :string
  end
end
