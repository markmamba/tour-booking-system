module Tours
  module Bookings
    class CreateRequest
      attr_reader :tour_id, :customer_name, :customer_email, :customer_phone, :number_of_passengers, :booking_date

      def initialize(params:)
        permitted_params = params.permit(
          :tour_id,
          :customer_name,
          :customer_email,
          :customer_phone,
          :number_of_passengers,
          :booking_date
        )
        @tour_id = permitted_params[:tour_id]
        @customer_name = permitted_params[:customer_name]
        @customer_email = permitted_params[:customer_email]
        @customer_phone = permitted_params[:customer_phone]
        @number_of_passengers = permitted_params[:number_of_passengers]
        @booking_date = permitted_params[:booking_date]
      end
    end
  end
end