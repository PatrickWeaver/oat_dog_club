class AddCoverImageToCovers < ActiveRecord::Migration
  def self.up
    add_attachment :covers, :cover_image
  end
  
  def self.down
    remove_attachment :covers, :cover_image
  end
end