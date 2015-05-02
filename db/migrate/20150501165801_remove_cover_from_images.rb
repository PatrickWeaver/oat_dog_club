class RemoveCoverFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :cover, :boolean
  end
end
