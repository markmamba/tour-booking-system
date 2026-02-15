module Tours
  module Bookings
    class CreateValidator
      include ActiveModel::Validations

      attr_reader :tour_id, :customer_name, :customer_email, :customer_phone, :number_of_passengers, :booking_date

      validates :tour_id, presence: true
      validates :customer_name, presence: true, length: { minimum: 2 }
      validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
      validates :customer_phone, presence: true
      validates :number_of_passengers, presence: true, numericality: { greater_than: 0 }
      validates :booking_date, presence: true, date: { after_or_equal_to: -> { Date.current } }

      def initialize(request:)
        @tour_id = request.tour_id
        @customer_name = request.customer_name
        @customer_email = request.customer_email
        @customer_phone = request.customer_phone
        @number_of_passengers = request.number_of_passengers
        @booking_date = request.booking_date
      end
    end
  end
end