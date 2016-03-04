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
    @year = params[:year]
    @month = Date::MONTHNAMES[params[:month].to_i]
    @records = Record.where(date: first_date .. last_date)
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
