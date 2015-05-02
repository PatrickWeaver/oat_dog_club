class AddZineIdToZineContent < ActiveRecord::Migration
  def change
    add_column :zine_contents, :zine_id, :integer
  end
end
