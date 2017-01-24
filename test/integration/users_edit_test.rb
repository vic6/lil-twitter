require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:victor)
    # log_in_as(@user)
  end

  test "Unsuccessful edit" do
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
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Victor"
    email = "vicvic@vic.vic"
    patch user_path(@user), params: { user: { name: name,
                                              email: email,
                                              password: "",
                                              password_confirmation: "" } }
  end
end
