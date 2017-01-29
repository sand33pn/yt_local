class AddThumbnailToLink < ActiveRecord::Migration[5.0]
  def change
  	add_column :links, :thumbnail, :string
  end
end
