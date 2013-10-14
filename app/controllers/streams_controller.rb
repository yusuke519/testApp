class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create, :set_data]

	def index
		@streams = Stream.all
	end

	def show
		@stream = Stream.find(params[:id])
		@dataPoints = @stream.data_points
		
		#Initialize Array Object
		#x: data of x axis
		#y: data of y axis
		#z: data of z axis
		#t: time
		x = Array.new()
		y = Array.new()
		z = Array.new()
		t = Array.new()

		firstTime = 0
		gon.test = 'NG'
		@dataPoints.each{|dp|
			@acces = dp.accelerations
			firstAcce = @acces[0]
			firstTime = firstAcce.time.to_i
			@acces.each{|acce|
				x << acce.x
				y << acce.y
				z << acce.z
				t << (acce.time.to_i - firstTime).to_f/1000.0
			}
			#x << @acces.pluck(:x)
			#t << @acces.pluck(:time)
			gon.test = 'OK'
		}
		gon.x = x
		gon.y = y
		gon.z = z
		gon.t = t
	end 
	
	def create
		stream = Stream.new
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
	
	def savefile
		render :text => "PAGE"
	end

	def selectfile

	end


	private
	#本当はモデルの機能として持たせるべきな気がする
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
