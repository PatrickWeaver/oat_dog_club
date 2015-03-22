class AddPositionToAuthorships < ActiveRecord::Migration
  def change
    add_column :authorships, :position, :integer
  end
end
