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
    @records = Record.where(date: first_date .. last_date).order('date ASC')

    @chart = build_monthly_chart(@records);
  end

  def yearly
    current_date = Date.new(params[:year].to_i, 1, 1)

    @year = params[:year]
    @summary = Hash.new

    all_total_stay = Array.new
    all_total_consumption = Array.new

    while current_date.year == params[:year].to_i do
      sum_stay = Record.where(:date => current_date.beginning_of_month .. current_date.end_of_month).sum(:stay);
      sum_consumption = Record.where(:date => current_date.beginning_of_month .. current_date.end_of_month).sum(:consumption);
      all_total_stay << sum_stay
      all_total_consumption << sum_consumption
      @summary[current_date.month] = {stay: sum_stay, consumption: sum_consumption}
      current_date = current_date.next_month
    end

    @chart = build_yearly_chart(all_total_stay, all_total_consumption)
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

    def build_monthly_chart(records)
      consumptions = Array.new
      stays = Array.new
      days = Array.new

      i = 1
      @records.each do |rec| 
        days << i
        consumptions << rec.consumption
        stays << rec.stay
        i += 1
      end

      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Valores por dia")
        f.xAxis(categories: days)
        f.series(name: "Estadia", data: stays)
        f.series(name: "Consumo", data: consumptions)

        f.yAxis [
          {title: {text: "Valor (R$)"}, min: 0 }
        ]

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({defaultSeriesType: "line", height: 300})
      end
    end

    def build_yearly_chart(all_total_stay, all_total_consumption)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.title(text: "Valores por mês")
        f.xAxis(categories: I18n.t('date.month_names').slice(1,12))
        f.series(name: "Estadia", data: all_total_stay)
        f.series(name: "Consumo", data: all_total_consumption)

        f.yAxis [
          {title: {text: "Valor (R$)"}, min: 0 }
        ]

        f.legend(verticalAlign: 'bottom', horizontalAlign: 'right', layout: 'horizontal')
        f.chart({defaultSeriesType: "line", height: 300})
      end
    end
end
