class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :user_id
      t.integer :zine_id

      t.timestamps
    end

    add_index :authorships, :user_id
    add_index :authorships, :zine_id
    add_index :authorships, [:user_id, :zine_id], unique: true
  end
end
