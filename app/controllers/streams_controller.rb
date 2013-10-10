class StreamsController < ApplicationController
	def create
		@stream = Stream.new
		if @stream.save
			render :text => "Success"
		else
			render :text => "Fail"
		end
	end

	private
	#本当はモデルの機能として持たせるべきな気がする
	def decodeData
		
	end
end
