require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'TestUser', email: 'fake@email.com',
                     password: 'hello', password_confirmation: 'hello')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = '    '
    assert_not @user.valid?
  end

  test 'name does not exceed 50 charactors' do
    @user.email = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'reject invalid email' do
    invalid_addresses = %w(
      user@example,com
      user_at_foo.org
      user.name@example.
      foo@bar_baz.com
      foo@bar+baz.com
    )

    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect}, should be invalid"
    end
  end

  test 'email is unique' do
    user_duplicate = @user.dup
    user_duplicate.email = @user.email.upcase
    @user.save
    assert_not user_duplicate.valid?
  end

  test 'email should be saved in lower-case' do
    mixed_case_email = 'TESt@emaL.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'password should not be blank' do
    @user.password = @user.password_confirmation = '    '
    assert_not @user.valid?
  end

  test 'password should contain at least 5 charactors' do
    @user.password = @user.password_confirmation = 'abcd'
    assert_not @user.valid?
  end

  test "authenticate? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    victor = users(:victor)
    smitty = users(:smitty)
    assert_not victor.following?(smitty)
    victor.follow(smitty)
    assert victor.following?(smitty)
    assert smitty.followers.include?(victor)
    victor.unfollow(smitty)
    assert_not victor.following?(smitty)
  end
end
