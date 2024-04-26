class AddCoverImageUrlToFilms < ActiveRecord::Migration[7.1]
  def change
    add_column :films, :cover_image_url, :string
  end
end
