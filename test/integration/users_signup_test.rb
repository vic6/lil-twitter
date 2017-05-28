require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name: "",
                                         email: 'blah',
                                         password: 'blah',
                                         password_confirmation: 'ahh' } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test 'valid signup' do
    assert_difference "User.count" do
      post users_path, params: { user: { name: "Dracula",
                                         email: "dracula@dog.com",
                                         password: "dracrulez",
                                         password_confirmation: "dracrulez" } }
    end
    follow_redirect!
    assert_not flash.empty?
    assert is_logged_in?
  end
end
