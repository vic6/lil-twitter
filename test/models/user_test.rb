require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'TestUser', email: 'fake@email.com')
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
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |email|
      @user.email = email
      assert_not @user.valid?, "#{email.inspect}, should be invalid"
    end
  end
end
