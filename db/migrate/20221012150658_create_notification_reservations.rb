class CreateNotificationReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :notification_reservations do |t|
      t.date :reservation_date, null: false
      t.references :task, null: false

      t.timestamps
    end
  end
end
