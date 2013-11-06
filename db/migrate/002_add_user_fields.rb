Sequel.migration do
  up do
    drop_column :users, :id
    add_column :users, :encrypted_tor_id, String, :text => false
    add_column :users, :nickname, String, :text => false
    add_column :users, :phone, String, :text => false
    add_column :users, :status, String, :text => true
    add_column :users, :api_key, String, :text => false
    add_index :users, :encrypted_tor_id
  end

  down do
    drop_column :users, :api_key
    add_column :users, :id, Integer
    drop_column :users, :encrypted_tor_id
    drop_column :users, :nickname
    drop_column :users, :phone
    drop_column :users, :status
  end
end