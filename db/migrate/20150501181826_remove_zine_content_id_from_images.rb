class RemoveZineContentIdFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :zine_content_id, :integer
  end
end
