class AddColumnsToCoupons < ActiveRecord::Migration
  def change
    add_column :admin_coupons, :enabled, :boolean, :default => true
    add_column :admin_coupons, :expiration_date, :timestamp
  end
  
  def self.down
    remove_column :admin_coupons, :enabled, :boolean
    remove_column :admin_coupons, :expiration_date, :timestamp
  end
end
