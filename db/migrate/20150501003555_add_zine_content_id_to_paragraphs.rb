class AddZineContentIdToParagraphs < ActiveRecord::Migration
  def change
    add_column :paragraphs, :zine_content_id, :integer
  end
end
