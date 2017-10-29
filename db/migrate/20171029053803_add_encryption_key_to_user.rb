class AddEncryptionKeyToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encryption_key, :text
  end
end
