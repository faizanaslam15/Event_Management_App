class Event < ApplicationRecord
  belongs_to :user
  has_many :rsvps
  has_many :attendees, through: :rsvps, source: :user
end
