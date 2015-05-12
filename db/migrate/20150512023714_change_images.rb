class ChangeImages < ActiveRecord::Migration
  def up
    change_column :images, :width, :integer, :default => 800
  end
end
