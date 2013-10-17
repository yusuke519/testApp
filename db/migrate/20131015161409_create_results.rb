class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.string :data_point_id
      t.string :type

      t.timestamps
    end
  end
end
