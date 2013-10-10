class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create]

	def index
		@streams = Stream.all
	end
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
