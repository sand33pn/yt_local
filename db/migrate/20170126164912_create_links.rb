class CreateLinks < ActiveRecord::Migration[5.0]
  def change
    create_table :links do |t|
      t.string :link_text
      t.string :ranking
      t.string :videoid

      t.timestamps
    end
  end
end
