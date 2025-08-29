ActiveAdmin.register Book do
  # ✅ Permit all the attributes you have
  permit_params :google_book_id, :title, :author, :publisher, :published_date,
                :description, :category, :language, :average_rating, :ratings_count,
                :country, :saleability, :is_ebook, :thumbnail, :small_thumbnail

  # ✅ Filters (only valid columns)
  filter :title
  filter :author
  filter :publisher
  filter :category
  filter :language
  filter :published_date
  filter :is_ebook

  # ✅ Index page (books listing)
  index do
    selectable_column
    id_column
    column :title
    column :author
    column :publisher
    column :published_date
    column :category
    column :language
    column :is_ebook
    column :average_rating
    column :ratings_count
    actions   # adds view, edit, delete buttons
  end

  # ✅ Show page (book details)
  show do
    attributes_table do
      row :id
      row :google_book_id
      row :title
      row :author
      row :publisher
      row :published_date
      row :description
      row :category
      row :language
      row :average_rating
      row :ratings_count
      row :country
      row :saleability
      row :is_ebook
      row :thumbnail do |book|
        image_tag(book.thumbnail) if book.thumbnail.present?
      end
      row :small_thumbnail do |book|
        image_tag(book.small_thumbnail) if book.small_thumbnail.present?
      end
      row :created_at
      row :updated_at
    end
  end

  # ✅ Form for create/update
  form do |f|
    f.inputs "Book Details" do
      f.input :google_book_id
      f.input :title
      f.input :author
      f.input :publisher
      f.input :published_date, as: :datepicker
      f.input :description
      f.input :category
      f.input :language
      f.input :average_rating
      f.input :ratings_count
      f.input :country, as: :string
      f.input :saleability
      f.input :is_ebook
      f.input :thumbnail
      f.input :small_thumbnail
    end
    f.actions
  end
end
