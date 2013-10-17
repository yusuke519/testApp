class PagesController < ApplicationController
	def top

	end

	def map

	end

	def load
		if !request.xhr?
			render :text => 'NG'
		else
			#Filterの設定をparamsから読み取る
			data_source = 'all'

			#設定に応じてデータを読み取る
			#if data_source == 'all'
			#	@streams = Stream.all
			#else
			#	@streams = Stream.find(data_source.to_i)
			#end
			#@streams.each{|s|
			#	@data_points << s.data_points
			#}

			#読み込んだデータをxml形式でreturnする
			#
			res = Hash.new()
			res[:name] = 'Jhon'
			res[:age] = '15'
			render :xml => res
		end
	end
end
