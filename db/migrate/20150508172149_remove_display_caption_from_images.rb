class RemoveDisplayCaptionFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :display_caption, :boolean
  end
end
