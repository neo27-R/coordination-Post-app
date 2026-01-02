class EnsureBodyOnEvents < ActiveRecord::Migration[7.2]
  def change
    add_column :events, :body, :text unless column_exists?(:events, :body)
  end
end
