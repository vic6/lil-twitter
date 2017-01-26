require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:victor)
  end

  test "Unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                                              email: "blah@blah",
                                              password: 'pie',
                                              password_confirmation: 'pots' } }
    assert_template 'users/edit'
    # assert_select 'div.field_with_errors'
  end

  test "Succesful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Victor"
    email = "vicvic@vic.vic"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
  end

  # tests if user is redirected to desired page after login
  test "Succesful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_path(@user)
    name = "Timmy Turner"
    email = 'tturner@odd.com'
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to(@user)
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
