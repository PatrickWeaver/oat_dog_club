class CreateZineContents < ActiveRecord::Migration
  def change
    create_table :zine_contents do |t|
      t.integer :order
      t.integer :orderable_id
      t.string :orderable_type

      t.timestamps
    end
  end
end
