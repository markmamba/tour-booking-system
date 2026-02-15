module Tours
  class Booking < ApplicationRecord
    belongs_to :driver, class_name: "Identities::User", optional: true
  end
end
