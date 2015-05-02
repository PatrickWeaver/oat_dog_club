class AddBorderColorToZineContents < ActiveRecord::Migration
  def change
    add_column :zine_contents, :border_color, :string, default: "#000000"
  end
end
