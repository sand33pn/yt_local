class RenameColumnNameToViewcount < ActiveRecord::Migration[5.0]
  def change
  	rename_column :links, :ranking, :view_count
  end
end
