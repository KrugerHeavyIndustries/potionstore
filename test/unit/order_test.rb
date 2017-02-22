require 'test_helper'

class OrderTest < ActiveSupport::TestCase

  def setup
    @order = orders(:first)
  end

  def test_status_description
    @dummy = Order.new
    {"P" => "Pending",
     "C" => "Complete",
     "F" => "Failed",
     "X" => "Cancelled"}.each do |abbrev, description|
      @dummy.status = abbrev
    assert_equal(@dummy.status_description , description)
    end
  end

  def test_create_order


  end

end
