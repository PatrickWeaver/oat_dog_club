class CreateParagraphs < ActiveRecord::Migration
  def change
    create_table :paragraphs do |t|
      t.string :header
      t.text :content
      t.string :border_color, default: "000000"
      t.integer :font_size, default: "16"
      t.integer :position
      t.integer :zine_id

      t.timestamps
    end

    add_index :paragraphs, [:zine_id, :updated_at]
  end
end
