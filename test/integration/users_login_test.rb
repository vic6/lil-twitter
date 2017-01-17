require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test 'login with invalid information' do
    # visit login path
    get login_path
    # verify new sessions renders correctly
    assert_template 'sessions/new'
    # post to sesstions path with invalid params hash
    post login_path, params: { session: { email: '', password: '' } }
    # verify new session form get re-rendered and flash appears
    assert_template 'sessions/new'
    assert_not flash.empty?
    # visit another page
    get root_path
    # verify flash doesn't apper on new page
    assert flash.empty?
  end
end
