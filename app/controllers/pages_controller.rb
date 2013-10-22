require 'pry'
class PagesController < ApplicationController
  def top
  end

  def map
	  render :template => 'layouts/cosmo4map'
  end

  def contact
  end

  def about
  end

  def term
  end

  def update
  end

  def load
	if !request.xhr?
	  render :text => 'NG'
	else
	  #Filterの設定をparamsから読み取る
	  data_source = 'all'

	  #設定に応じてデータを読み取る
	  if data_source == 'all'
		@streams = Stream.all
	  else
		#        @streams = Stream.find(data_source.to_i)
	  end

	  #3重にしたらさすがに読み込み結構時間かかる．
	  ress = Array.new()
	  @streams.each{|s|
		s.data_points.each{|dp|
		  dp.results.each{|r|
			ress << Hash.new()
			ress.last[:from_lat] = dp[:from_lat]
			ress.last[:from_lng] = dp[:from_lng]
			ress.last[:to_lat] = dp[:to_lat]
			ress.last[:to_lng] = dp[:to_lng]
			ress.last[:value] = r[:value]
		  }
		}
	  }
	  #読み込んだデータをxml形式でreturnする
	  #
	  res = Hash.new()
	  res[:lat] = 35.67975631042715
	  res[:lng] = 139.73548426066236
	  res[:value] = 'Bump'
	  render :json => ress
	end

  end
end
