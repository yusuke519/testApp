class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create, :set_data]

	def index
		@streams = Stream.all
	end

	def show
		@stream = Stream.find(params[:id])
		@dataPoints = @stream.data_points
		x = Array.new()
		y = Array.new()
		z = Array.new()
		t = Array.new()

		temp_x = Array.new()
		temp_y = Array.new()
		temp_z = Array.new()
		temp_t = Array.new()
		gon.test = 'NG'
		@dataPoints.each{|dp|
			@acces = dp.accelerations
			@acces.each{|acce|
				x << acce.x
				y << acce.y
				z << acce.z
				t << acce.time
			}
			#x << @acces.pluck(:x)
			#t << @acces.pluck(:time)
			gon.test = 'OK'
		}
		temp_x = x[0..6]
		temp_y = y[0..6]
		temp_z = z[0..6]
		temp_t = t[0..6]
		gon.temp_x = temp_x
		gon.temp_y = temp_y
		gon.temp_z = temp_z
		gon.temp_t = temp_t
		gon.x = x
		gon.y = y
		gon.z = z
		gon.t = t
	end 
	def create
		@stream = Stream.new
		if @stream.save
			render :text => "#{@stream.id}"
		else
			render :text => "Fail"
		end
	end

	def set_data
		@stream = Stream.find(params[:stream_id])
		@data_point = @stream.data_points.create(data_point_param)

		if @data_point.save
			addAcce(@data_point, params[:data])
			render :text => "Success"
		else
			render :text => "Fail"
		end
	end

	private
	#本当はモデルの機能として持たせるべきな気がする
	def decodeData

	end

	def addAcce(dp, data)
		dataAry = Array.new()
		sequence = 0
		temp = Array.new()
		data.split(' ').each{|point|
			temp = point.split(',')
			t = temp[0]
			x = temp[1].to_f
			y = temp[2].to_f
			z = temp[3].to_f
			dp.accelerations.create(:sequence => sequence, :time => t, :x => x, :y => y, :z => z)
			sequence = sequence + 1
		}
	end


	def data_point_param
		params.permit(:start_time, :stop_time, :data_type)
	end
end
