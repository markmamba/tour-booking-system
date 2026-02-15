module Identities
  class User < ApplicationRecord
    self.table_name = "identities_users"
    has_secure_password

    has_many :bookings, class_name: "Tours::Booking", foreign_key: "driver_id"
  end
end
