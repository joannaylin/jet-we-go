class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :plane
  belongs_to :airport
  validates_presence_of :rental_start
  validates_presence_of :rental_end
  validate :end_date_after_start_date
  validate :start_date_not_before_today

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
end
