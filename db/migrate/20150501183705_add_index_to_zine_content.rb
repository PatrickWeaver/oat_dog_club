class AddIndexToZineContent < ActiveRecord::Migration
  def change
    add_index :zine_contents, [:zine_id, :updated_at]
  end
end
