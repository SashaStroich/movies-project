class CreateFilms < ActiveRecord::Migration[7.1]
  def change
    create_table :films do |t|
      t.string :name
      t.text :description
      t.integer :release_year
      t.string :director
      t.integer :duration
      t.text :genres, array: true, default: []

      t.timestamps
    end
  end
end
