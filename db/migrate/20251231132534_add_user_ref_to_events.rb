class AddUserRefToEvents < ActiveRecord::Migration[7.2]
  def change
    return if column_exists?(:events, :user_id)

    add_reference :events, :user, null: false, foreign_key: true
  end
end
