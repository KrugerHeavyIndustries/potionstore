require 'test_helper' 

class AdminControllerTest < ActionController::TestCase
  fixtures :products

  def test_index_with_no_password
    get :index
    assert_redirected_to '/admin/login'
    assert_equal(session[:intended_url] , 'http://test.host/admin')
  end

  def test_login_with_faulty_password
    post :login, params: {:username => 'joeblow', :password => 'totallyfakingit'}
    assert_template 'login'
    assert_response :success
  end

  def test_login_with_good_password
    post :login, params: {
       :username => $STORE_PREFS['admin_username'],
       :password => $STORE_PREFS['admin_password']}

    assert_redirected_to :action => 'index'
  end

  def generate_coupons_blank
    process 'generate_coupons', params: {}, session: { :logged_in => true }
    assert_response :success
    assert_template 'generate_coupons'
  end
end
