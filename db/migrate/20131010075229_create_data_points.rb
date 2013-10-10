class CreateDataPoints < ActiveRecord::Migration
  def change
    create_table :data_points do |t|
      t.string :start_time
      t.string :stop_time
      t.string :data_type
      t.string :stream_id

      t.timestamps
    end
  end
end
