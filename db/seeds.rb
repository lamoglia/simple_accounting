# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'date'

first_day = Date.new(2000,1,1)
today = Date.today
last_day_current_month = Date.new(today.year, today.month, 1).next_month.prev_day

(first_day .. last_day_current_month).each do |date|
  if !Record.exists?(date: date)
    record = Record.new
    record.date = date
    record.stay = 0
    record.consumption = 0
    record.save
  end
end
