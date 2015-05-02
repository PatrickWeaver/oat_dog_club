class RemoveZineIdFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :zine_id, :integer
  end
end
