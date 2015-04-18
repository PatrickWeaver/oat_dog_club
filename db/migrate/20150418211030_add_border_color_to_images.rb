class AddBorderColorToImages < ActiveRecord::Migration
  def change
    add_column :images, :border_color, :string, default: "000000"
  end
end
