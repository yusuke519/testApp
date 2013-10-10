class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create, :set_data]

	def index
		@streams = Stream.all
	end

	def show
		@stream = Stream.find(params[:id]);
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
	#$BK\Ev$O%b%G%k$N5!G=$H$7$F;}$?$;$k$Y$-$J5$$,$9$k(B
	def decodeData

	end

	def addAcce(dp, data)
		dataAry = Array.new()
		sequence = 0
		data.split(' ').each{|point|
			temp == point.split(',')
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
