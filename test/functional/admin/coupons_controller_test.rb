require 'test_helper'

class Admin::CouponsControllerTest < ActionController::TestCase

  setup do
    @coupon = admin_coupons(:one)
  end

  test "should get index" do
    session[:logged_in] = true
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    session[:logged_in] = true
    get :new
    assert_response :success
  end

  test "should create admin_coupon" do
    assert_difference('Admin::Coupon.count') do
      coupon_attributes = @coupon.attributes
      coupon_attributes[:quantity] = 1
      post :create, { admin_coupon: coupon_attributes }, { logged_in: true }
      #print_exchange "show admin_coupon"
    end

    assert_redirected_to admin_coupons_path
  end

  test "should show admin_coupon" do
    get :show, { id: @coupon.code }, { logged_in: true }
    assert_response :success
  end

  test "should get edit" do
    get :edit, { id: @coupon }, { logged_in: true }
    assert_response :success
  end

  test "should update admin_coupon" do
    put :update, { id: @coupon, admin_coupon: @coupon.attributes }, { logged_in: true }
    assert_redirected_to admin_coupons_path
  end

  test "should destroy admin_coupon" do
    assert_difference('Admin::Coupon.count', -1) do
      delete :destroy, { id: @coupon }, { logged_in: true }
    end

    assert_redirected_to admin_coupons_path
  end
end
