class Record < ActiveRecord::Base
  validates :consumption, presence: true, length: { maximum: 8 }, numericality: { greater_than_or_equal_to: 0 }
  validates :stay, presence: true, length: { maximum: 8 }, numericality: { greater_than_or_equal_to: 0 }
  validates :date, presence: true, uniqueness: true
end
