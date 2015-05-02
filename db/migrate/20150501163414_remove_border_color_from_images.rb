class RemoveBorderColorFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :border_color, :string
  end
end
