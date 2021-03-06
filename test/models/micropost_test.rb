require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:victor)
    # @micropost = Micropost.new(content: 'Blah blah', user_id: @user.id)
    @micropost = @user.microposts.build(content: 'Blah blah')
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = 'ahhh' * 100
    assert_not @micropost.valid?
  end

  test "microposts should be ordered by most recent" do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
