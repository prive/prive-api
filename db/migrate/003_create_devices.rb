Sequel.migration do
  up do
    create_table(:devices) do
      String :encrypted_device_id, :text => false
      String :encrypted_tor_id, :text => false
    end
    add_index :devices, :encrypted_tor_id
    add_index :devices, :encrypted_device_id
    add_index :devices, [ :encrypted_device_id, :encrypted_tor_id ], :unique => true
  end

  down do
    drop_table(:devices)
  end
end
