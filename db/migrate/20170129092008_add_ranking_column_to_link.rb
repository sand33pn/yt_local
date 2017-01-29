class AddRankingColumnToLink < ActiveRecord::Migration[5.0]
  def change
  	add_column :links, :ranking, :float
  end
end
