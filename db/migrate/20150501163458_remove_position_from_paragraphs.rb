class RemovePositionFromParagraphs < ActiveRecord::Migration
  def change
    remove_column :paragraphs, :position, :integer
  end
end
