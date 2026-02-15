module Tours
  module Bookings
    class CreateManager

      def self.execute(request:)
        validator = Tours::Bookings::CreateValidator.new(request: request)

        if validator.invalid?
          raise Errors::ValidationError.new(validator.errors)
        end

        booking = Tours::Booking.new(
          tour_id: request.tour_id,
          customer_name: request.customer_name,
          customer_email: request.customer_email,
          customer_phone: request.customer_phone,
          number_of_passengers: request.number_of_passengers,
          booking_date: request.booking_date
        )

        booking.save!
        return booking
      end
    end
  end
end