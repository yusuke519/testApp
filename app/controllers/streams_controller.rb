class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create, :add_data]

	def index
		@streams = Stream.all
	end

	def create
		@stream = Stream.new
		if @stream.save
			render :text => "#{@stream.id}"
		else
			render :text => "Fail"
		end
	end

	def add_data
		@stream = Stream.find(params[:stream_id])
		@data_point = @stream.data_points.create(data_point_param)
	end

	private
	#$BK\Ev$O%b%G%k$N5!G=$H$7$F;}$?$;$k$Y$-$J5$$,$9$k(B
	def decodeData

	end


	def data_point_param
		params.permit(:start_time, :stop_time, :data_type)
	end
end
