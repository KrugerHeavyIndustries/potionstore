# Add a UID to all orders
require 'uid'

class AddUidToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :unique_id, :string, :limit => 16
    Order.reset_column_information

    Order.all.each do |o|
      o.uuid = uid()
      o.skip_cc_validation = true
      o.save!
    end

    change_column :orders, :unique_id, :string, :limit => 16, :null => false
  end

  def self.down
    remove_column :orders, :uuid
  end
end
