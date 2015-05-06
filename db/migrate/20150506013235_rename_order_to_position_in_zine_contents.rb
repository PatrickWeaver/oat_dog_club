class RenameOrderToPositionInZineContents < ActiveRecord::Migration
  def change
    rename_column :zine_contents, :order, :position
  end
end
