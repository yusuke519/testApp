require 'pry'

class StreamsController < ApplicationController
	skip_before_filter :verify_authenticity_token ,:only=>[:create, :set_data, :savefile]

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
		@user = User.find(params[:user_id])
		@stream = @user.streams.create()
		if @stream.save
			render :text => "#{@stream.id}"
		else
			render :text => "Fail"
		end
	end

	def set_data
		stream = Stream.find(params[:stream_id])
		@data_point = stream.data_points.create(data_point_param)
		if @data_point.save
			addAcce(@data_point, params[:data])
			render :text => "Success"
		else
			render :text => "Fail"
		end
	end

	def savefile
		acceFile = params[:acce]
		estimationFile = params[:estimate]
		latlngFile = params[:latlng]

		File2Model.new(acceFile,estimationFile,latlngFile).make

		render :text => "TEST"
	end

	def selectfile

	end

	def sensor

	end

	private
	#$BK\Ev$O%b%G%k$N5!G=$H$7$F;}$?$;$k$Y$-$J5$$,$9$k(B
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
	class File2Model
		def initialize(acceF, estimationF, latlngF)
			@acceF = acceF
			@estimationF = estimationF
			@latlngF = latlngF
			ard = acceF.read.split("\n")
			erd = estimationF.read.split("\n")
			lrd = latlngF.read.split("\n")
			@acceD = ard
			@estimationD = erd
			@latlngD = lrd
		end

		def make
			#$B$3$N=hM}$b(BAjax$B!J$C$F$$$&$+HsF14|$G=q$$$?J}$,NI$$5$$,$9$k!K(B
			#Ajax$B$GAw$C$F!"HsF14|$G=hM}$9$k!%$,@52r!)(B
			#
			#Ajax:$B%/%i%$%"%s%HB&$NIA2hB.EY$NLdBj(B
			#$B%5!<%P!<B&$N=hM}B.EY!J$J$$$7JBNs=hM}$NLdBj!K(B
			#
			#
			#Create Stream
			stream = Stream.new
			stream.save
			#Create DataPoint
			result_type = "Bump"
			result_value = ""
			index = 0
			@estimationD.each{|line|
				temp = line.split(" ")
				fromTime = temp[0].to_f
				toTime = temp[1].to_f

				from = getLatlng(fromTime)
				to = getLatlng(toTime)
				if temp[2].to_i == 0
					result_value = "Flat"
				else 
					result_value = "Bump"
				end
				data_point = stream.data_points.create(:start_time => fromTime.to_s, :stop_time => toTime.to_s, :data_type => "File", :from_lat => from[:lat], :from_lng => from[:lng], :to_lat => to[:lat], :to_lng => to[:lng])
				#Create Result
				data_point.results.create(:type => "", :value => result_value)		

				acceLine = @acceD[index].split(' ')
				ad = acceLine[2]
				addAcce(data_point, ad)

			}
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

		def getLatlng(time)
			lat=""
			lng=""
			tmp=""
			elm=""
			@latlngD.each{|line|
				if(tmp == "")
					tmp = line.split(" ")
				end
				elm = line.split(" ")
				if((tmp[0].to_f <= (time.to_f) && time.to_f < elm[0].to_f))
					lat = tmp[1].to_f * 1 + (elm[1].to_f - tmp[1].to_f) * ((time - tmp[0].to_f) / (elm[0].to_f - tmp[0].to_f))
					lng = tmp[2].to_f * 1 + (elm[2].to_f - tmp[2].to_f) * ((time - tmp[0].to_f) / (elm[0].to_f - tmp[0].to_f))
					h = Hash.new()
					h[:lat]=lat
					h[:lng]=lng
					return h
				end

				tmp = elm
			}
			h = Hash.new()
			h[:lat]=nil
			h[:lng]=nil
			return h
		end
	end

	def data_point_param
		params.permit(:start_time, :stop_time, :data_type)
	end
end
