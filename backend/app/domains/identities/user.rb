module Identities
  class User < ApplicationRecord
    self.table_name = "identity_users" # Ensures mapping to the correct table
    has_secure_password

    has_many :bookings, class_name: "Tours::Booking", foreign_key: "driver_id"
  end
end
