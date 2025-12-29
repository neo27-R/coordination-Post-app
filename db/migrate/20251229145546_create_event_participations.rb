class CreateEventParticipations < ActiveRecord::Migration[7.2]
  add_index :event_participations, [:user_id, :event_id], unique: true
  
  def change
    create_table :event_participations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
