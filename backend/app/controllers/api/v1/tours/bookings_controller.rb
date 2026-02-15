module Api
  module V1
    module Tours
      class BookingsController < BaseController
        # Tourists don't need to log in to make a booking
        skip_before_action :authenticate_request, only: [:create]

        def index
          # In the future, we can filter this by status (pending, confirmed)
          bookings = ::Tours::Booking.all.order(created_at: :desc)
          render json: bookings
        end

        def create
          request = Tours::Bookings::CreateRequest.new(params: params)
          booking = Tours::Bookings::CreateManager.execute(request: request)

          render json: booking, status: :created
        end
      end
    end
  end
end