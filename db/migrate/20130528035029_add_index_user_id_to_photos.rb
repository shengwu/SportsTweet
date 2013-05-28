class AddIndexUserIdToPhotos < ActiveRecord::Migration
  def change
  	add_index :photos, :id_str
  end
end
