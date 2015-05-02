class RemoveBorderColorFromParagraphs < ActiveRecord::Migration
  def change
    remove_column :paragraphs, :border_color, :string
  end
end
