class RemoveZineIdFromParagraphs < ActiveRecord::Migration
  def change
    remove_column :paragraphs, :zine_id, :integer
  end
end
