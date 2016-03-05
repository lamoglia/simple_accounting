desc "This task creates zeroed records for the current month @ day 1"
task :minutely_task => :environment do
  if Date.today.day == 1
    first_day_current_month = Date.new(Date.today.year, Date.today.month, 1)
    last_day_current_month = first_day_current_month.next_month.prev_day

    (first_day_current_month .. last_day_current_month).each do |date|
      if !Record.exists?(date: date)
        record = Record.new
        record.date = date
        record.stay = 0
        record.consumption = 0
        record.save
      end
    end
  end
end