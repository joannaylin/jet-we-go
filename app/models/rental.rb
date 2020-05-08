class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :plane
  belongs_to :airport
  validates_presence_of :rental_start
  validates_presence_of :rental_end
  validate :end_date_after_start_date
  validate :start_date_not_before_today, on: :create
  validate :return_date_not_before_start_date

  def rental_period
    "#{(rental_end.to_date - rental_start.to_date).to_i} Days"
  end

  def rental_period_actual
    day_count = (rental_return.to_date - rental_start.to_date).to_i
    if day_count == 0
      day_count = 1
    end
    day_count
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
    while i < dest_a.length 
      dest_3 << dest_a[i][0]
      i += 1
    end
    if dest_3.length > 3
      dest_3[0..2]
    else
      dest_3
    end
  end
    
  def self.top_3_plane
    dest = self.all.group_by{|rental| rental.plane.model}
    dest_a = dest.sort_by{|k,v| v.length}.reverse
    dest_3 = []
    i = 0
    while i < dest_a.length
      dest_3 << dest_a[i][0]
      i += 1
    end
    if dest_3.length > 3
      dest_3[0..2]
    else
      dest_3
    end
  end

  def self.top_rated_plane
    if self.count > 0
      plane = self.group(:plane_id).average(:plane_rating)
      rated_planes = plane.max_by{ |k,v| v }
      top_plane = Plane.find(rated_planes[0])
      top_plane.model
    else
      "no rated plane"
    end
  end

  private

  def end_date_after_start_date
    return if rental_end.blank? || rental_start.blank?
    if rental_end < rental_start
      errors.add(:rental_end, "must be after the start date!")
    end
 end

  def start_date_not_before_today
    return if rental_end.blank? || rental_start.blank?
    if rental_start < DateTime.now.to_date
      errors.add(:rental_start, "cannot start a rental before today!")
    end
  end

  def return_date_not_before_start_date
    return if rental_return.blank? || rental_start.blank?
    if rental_return < rental_start
      errors.add(:rental_start, "cannot return before rental start!")
    end
  end
end
