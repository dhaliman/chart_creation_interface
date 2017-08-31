require 'charts'
class ChartsController < ApplicationController

  API_KEY = 'AIzaSyBZCSyQ4hpeiRGo4lVSR9rU_SwrAsclcMU'

  def index
    @charts = Chart.all
  end

  def new
    @chart = Chart.new
  end

  def show
    @chart = Chart.find(params[:id])
    spreadsheet = Google::SpreadSheet.new(@chart.url.split('/')[5], API_KEY)
    # map removes the brackets around the values
    @x_axis = spreadsheet.read_single_range(@chart.x_axis.range).json_to_hash['values'].map! {|x| x[0] }
    @series = @chart.series.map { |s| spreadsheet.read_single_range(s.range).json_to_hash['values']}
    @series.each {|s| s.map!{|e| e[0]} } # removes the brackets around the values
  end

  def create
    @chart = Chart.new(chart_params)
    respond_to do |format|
      if @chart.save
        XAxis.create(range: params[:chart][:x_axis], chart_id: @chart.id)
        params[:chart][:series].each do |series|
          @chart.series.create(range: series)
        end
        format.html { redirect_to chart_url(@chart)}
      else
        format.html { render :new }
      end
    end
  end

  private

  def chart_params
    params.require(:chart).permit(:title, :url, :type_of)
  end
end
