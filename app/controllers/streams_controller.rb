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

	def set_data
		@stream = Stream.find(params[:stream_id])
		@data_point = @stream.data_points.create(data_point_param)

		if @data_point.save
			render :text => "Success"
		else
			render :text => "Fail"
		end
	end

	private
	#本当はモデルの機能として持たせるべきな気がする
	def decodeData

	end


	def data_point_param
		params.permit(:start_time, :stop_time, :data_type)
	end
end
