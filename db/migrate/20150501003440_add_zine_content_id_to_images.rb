class AddZineContentIdToImages < ActiveRecord::Migration
  def change
    add_column :images, :zine_content_id, :integer
  end
end
