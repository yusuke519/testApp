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
	#$BK\Ev$O%b%G%k$N5!G=$H$7$F;}$?$;$k$Y$-$J5$$,$9$k(B
	def decodeData
		
	end
end
