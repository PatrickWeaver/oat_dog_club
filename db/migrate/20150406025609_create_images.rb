class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :url
      t.integer :zine_id
      t.boolean :cover, default: false
      t.integer :paragraph_id
      t.integer :height
      t.integer :width, default: 400
      t.string :caption
      t.boolean :display_caption, default: false

      t.timestamps
    end
    add_index :images, [:zine_id, :caption, :created_at]
  end
end
