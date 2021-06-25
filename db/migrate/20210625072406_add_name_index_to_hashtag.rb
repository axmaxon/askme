class AddNameIndexToHashtag < ActiveRecord::Migration[6.1]
  def change
    add_index :hashtags, :name, unique: true
  end
end
