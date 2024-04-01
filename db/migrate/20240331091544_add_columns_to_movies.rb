class AddColumnsToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :mid, :integer
    add_column :movies, :genre, :string
    add_column :movies, :original_title, :string
    add_column :movies, :overview, :text
    add_column :movies, :poster, :string
    add_column :movies, :popularity, :float
  end
end
