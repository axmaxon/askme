class AddProfileColorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :profile_color, :string
  end
end
