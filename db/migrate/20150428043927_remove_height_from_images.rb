class RemoveHeightFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :height, :integer
  end
end
