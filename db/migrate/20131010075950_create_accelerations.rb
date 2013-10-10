class CreateAccelerations < ActiveRecord::Migration
  def change
    create_table :accelerations do |t|
      t.integer :sequence
      t.string :time
      t.float :x
      t.float :y
      t.float :z
      t.string :data_point_id

      t.timestamps
    end
  end
end
