class RecordsController < ApplicationController

  def index
    #redirects to monthly data of current month.
    today = Date.today
    redirect_to action: 'monthly', year: today.year, month: today.month
  end

  def monthly
    require 'date'
    first_date = Date.new(params[:year].to_i, params[:month].to_i,1)
    last_date = first_date.next_month.prev_day
    
    @date = first_date
    @records = Record.where(date: first_date .. last_date)
  end

  def yearly
    current_date = Date.new(params[:year].to_i, 1, 1)
    
    @year = params[:year]
    @summary = Hash.new

    while current_date.year == params[:year].to_i do
      sum_stay = Record.where(:date => current_date.beginning_of_month .. current_date.end_of_month).sum(:stay);
      sum_consumption = Record.where(:date => current_date.beginning_of_month .. current_date.end_of_month).sum(:consumption);
      @summary[current_date.month] = {stay: sum_stay, consumption: sum_consumption}
      current_date = current_date.next_month
    end
  end

  def create
    @record = Record.new(record_params)

    if @record.save
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = Record.find(params[:id])
    @record.destroy
    head :no_content
  end
  
  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  private

    def record_params
      params.require(:record).permit(:stay,:consumption,:date)
    end
end
