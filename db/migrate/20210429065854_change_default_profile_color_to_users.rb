class ChangeDefaultProfileColorToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :profile_color, from: nil, to: '#005a55'

    reversible do |dir|
      dir.up { User.where(profile_color: nil).update_all(profile_color: '#005a55') }
    end
  end
end
