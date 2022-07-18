class Users < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :tokens, :integer, default:100
  end
end
