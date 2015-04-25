class AddShowTitleToZines < ActiveRecord::Migration
  def change
    add_column :zines, :show_title, :boolean, default: true;
  end
end
