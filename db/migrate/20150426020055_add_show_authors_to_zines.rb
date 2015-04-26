class AddShowAuthorsToZines < ActiveRecord::Migration
  def change
    add_column :zines, :show_authors, :boolean, default: true
  end
end
