class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :plane
  belongs_to :airport
  validates_presence_of :rental_start
  validates_presence_of :rental_end
  validate :end_date_after_start_date
  validate :start_date_not_before_today
  validate :return_date_not_before_start_date

  def rental_period
    "#{(rental_end.to_date - rental_start.to_date).to_i} Days"
  end

  def rental_period_actual
    (rental_return.to_date - rental_start.to_date).to_i
  end

  def rental_status
    if self.rental_return
      status = "Returned"
    else
      status = "Active"
    end
    status
  end

  def amount_owed
    "$" + "#{rental_cost}"
  end

  def self.top_3_dest
    dest = self.all.group_by{|rental| rental.airport.city.name}
    dest_a = dest.sort_by{|k,v| v.length}.reverse
    dest_3 = []
    i = 0
    3.times do |i|
      dest_3 << dest_a[i][0]
    end
    dest_3
  end
    
  def self.top_3_plane
    dest = self.all.group_by{|rental| rental.plane.model}
    dest_a = dest.sort_by{|k,v| v.length}.reverse
    dest_3 = []
    i = 0
    3.times do |i|
      dest_3 << dest_a[i][0]
    end
    dest_3
  end

  private

  def end_date_after_start_date
    return if rental_end.blank? || rental_start.blank?
    if rental_end < rental_start
      errors.add(:rental_end, "must be after the start date")
    end
 end

  def start_date_not_before_today
    return if rental_end.blank? || rental_start.blank?
    if rental_start < DateTime.now
      errors.add(:rental_start, "cannot be before today")
    end
  end

  def return_date_not_before_start_date
    return if rental_return.blank? || rental_start.blank?
    if rental_return < rental_start
      errors.add(:rental_start, "cannot return before retnal start")
    end
  end
end
