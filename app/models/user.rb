class User < ApplicationRecord
   has_secure_password
  has_many :events
  has_many :rsvps
  has_many :rsvped_events, through: :rsvps, source: :event
end

