class CreateIdentitiesUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :identities_users do |t|
      t.string :email
      t.string :password_digest, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :vehicle_type
      t.string :vehicle_plate_number

      t.timestamps
    end
    add_index :identities_users, :email, unique: true
  end
end
