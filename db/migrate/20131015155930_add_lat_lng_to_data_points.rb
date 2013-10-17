class AddLatLngToDataPoints < ActiveRecord::Migration
  def change
    add_column :data_points, :from_lat, :float
    add_column :data_points, :from_lng, :float
    add_column :data_points, :to_lat, :float
    add_column :data_points, :to_lng, :float
  end
end
