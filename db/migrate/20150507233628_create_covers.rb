class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.integer :zine_id
      t.integer :width, default: 400
      t.string :border_color, default: "#000000"

      t.timestamps
    end
  end
end
