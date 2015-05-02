class RemoveZineContentIdFromParagraphs < ActiveRecord::Migration
  def change
    remove_column :paragraphs, :zine_content_id, :integer
  end
end
