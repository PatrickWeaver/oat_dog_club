class CreateZines < ActiveRecord::Migration
  def change
    create_table :zines do |t|
      t.string :title
      t.boolean :published, default: false

      t.timestamps
    end

    add_index :zines, [:title, :created_at, :updated_at]
  end
end
