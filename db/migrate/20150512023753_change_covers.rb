class ChangeCovers < ActiveRecord::Migration
  def up
    change_column :covers, :width, :integer, :default => 800
  end
end
