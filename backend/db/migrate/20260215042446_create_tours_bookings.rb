class CreateToursBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :tours_bookings do |t|
      # Customer Details
      t.string :customer_name, null: false
      t.string :customer_email, null: false
      t.string :customer_whatsapp_line, null: false

      # Service Logic
      t.string :service_type, null: false

      # Logistics
      t.datetime :pickup_datetime, null: false
      t.string :pickup_address, null: false
      t.string :dropoff_address
      t.integer :passenger_count, default: 1
      t.integer :luggage_count, default: 0

      # Specifics
      t.string :flight_number
      t.integer :duration_hours

      # Status & Payment
      t.integer :status, default: 0
      t.decimal :quoted_price, precision: 10, scale: 2

      # Relations
      t.references :driver, null: true, foreign_key: { to_table: :identities_users }

      t.timestamps
    end
  end
end
